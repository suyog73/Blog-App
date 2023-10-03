import 'package:flutter_dotenv/flutter_dotenv.dart';

const String kAppName = "Blog App";

String kBASEURL = dotenv.env['BASE_URL'].toString();
String kHeader = dotenv.env['API_HEADER'].toString();

const String kFavoriteBox = "favorite_box";
const String kBloggerBox = "blogger_box";

const String kDescription =
    "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available. In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.";
