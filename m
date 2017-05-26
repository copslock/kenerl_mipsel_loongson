Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 May 2017 02:39:37 +0200 (CEST)
Received: from mail-sn1nam01on0088.outbound.protection.outlook.com ([104.47.32.88]:46656
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994800AbdEZAiivcCjJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 26 May 2017 02:38:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=jhvmtc8cSw4Guw3tSuwhL3iqvJs62Cijin40n0ei8hM=;
 b=orrjI+NCeGRZ7kEiiYZk8TcX2heucfqOxA+1KoH/SrIklEvYRPeJDwMLj1gMxLe5jJrVBn0lRQ8JEv8MndDpnPY/Yd0VLgmReWelV9TXMHTESdIR77EqQr7/3XJhgLvZqI0Cv11AWT/B7LDdjsJ0BcpDXhaeay8D4nWCxPcfHFY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cavium.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM5PR07MB3500.namprd07.prod.outlook.com (10.164.153.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1101.14; Fri, 26 May 2017 00:38:32 +0000
From:   David Daney <david.daney@cavium.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 2/5] MIPS: Correctly define DBSHFL type instruction opcodes.
Date:   Thu, 25 May 2017 17:38:23 -0700
Message-Id: <20170526003826.10834-3-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20170526003826.10834-1-david.daney@cavium.com>
References: <20170526003826.10834-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0034.namprd07.prod.outlook.com (10.162.96.44) To
 DM5PR07MB3500.namprd07.prod.outlook.com (10.164.153.31)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR07MB3500:
X-MS-Office365-Filtering-Correlation-Id: 59e5a47a-3ec1-401b-253c-08d4a3cf8987
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:DM5PR07MB3500;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;3:uuzQpziERt+H4fcYZhmstFw3Af5CTbsZWR9x+raRJ0EEL0PtSV4mzXh2l/WC5S3MbUP9xkA/n9i6RZN0pm/Y5235mSu5ZipxLEniLpVoo532Y6TPJSovnatMpKGp43DfPuS/gEG6LpMcPUfavLPZOrg9KVs6qSjrk7UgSKkHrsSVL+tO0wguBXhysy0A8V+afO9ers+F+EiyHROv6Xs9qCt9FvNRqD0Jmlsxvwrm6+FOwjuGaOKDUfFIGhAYGck21ZCFHQayR58p4AnLpQIF4XQRklxMj8xixfJx5C6l3zvMNWs6N/vMyUf7He2e179cXBbS3VCg17bF8aT23TWtrA==;25:xuv6SinA3YFksc3f+VbY8EhsaG45tqDZQLunG9W5a9MOZM4GCGBPj0es+73RbezA32E3QGX9Hy2JFzoKVqmEUQzC9KauctFuYh2VtYyC9Xd1xZM7Z/he7AlX9y8sdZb6rzmjYXAjx9cv651VSXr+Y82amTwnOBj8rb5eWrchZlvJHKhQTGh4NoUr44AtfNbyPZvsTq6vggOaVbtTth4FhXPRW2A5EzUAa+rDF1bgJwoC54fjEfS5m3EPcVO6PgJne4XcBKiRaecNaGIYHIZXP0vsAaFzSykPkjUrOODBSzLUKDufQ9reNlr571nylEpacU3MOEAmtQEoQXSl5SovGUm/jIaLJUiMLSDDx5x2IE/9EzsbAcD3Z7GBgUxE2hYYuBt3J7JFeqUbQglNfKTNgY3wsridxghnLJ1HMneYK+gN5yveFPHHb0WVkrBOyREUseWxb/XkmIikvO7J95a7QlT/50FhjitmZYebvozJscg=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;31:WyBDY9AFiZoU9egZQmq7N9j97OQzXek908JO+IjzctqDzckUKrTX5Sc2+XqFKgpqgNiXLCOnm/TOSZlS+ll0yCnnMnwgYSJsXYzhTZAwATKpDqbL4Ngb2JTX94RkZqhV8gQEaohB73GBUwnUAaqjNPRI65JNCUupLjliE06onJJ0Tnvc4AyxaR5a4Xw0dhmkJ6aYxtt8OQzEGA3ooPsHaKtF6sgC9fTrILVws0sSBDo=;20:mF5SP9rxZOVdIQ/UVL89Sh8FeKZw6UMeQJu5k0md0NGhv1FpX09y04G9cY/PV8e8MdUYCXfaWFa5rnOQ71TJ2pFmcpZzoSxlf9e1rLymmlMeIs4wV5hyeHIv+h9dAdpAaQEHYqwU3iDMdbIcB5pnA6n+JjszoiB1XFVT2UKY7+9ehIkF1/7UOEVqbiLVOtKF2Oc3n3gNEdA4XSgQgoWuzqP+cRJJI6d0TqO9yBhMUMq6p3BPUwMDkvQ34g8HaQGuzB4A7ALkuL9o+qut+mN84jFWfzDfticGM0RwLgDyYwdjt7YKP5YA8qXxigorMFs8EbJa+lmsX8406FT8m/VBUo/Htk64j3bS+4Mn5XZ4t1rS458g1y/LfE/Ferm/Aoxmckrv5M7lIgAo+vXlOcniVzSSIlvptFZfwLnCk7f73Pmv0iyFRao2R32ywT5XbEpgQFS+CSjHCw4dYEJ0sJnmHgAo7cGujgOolNmqV1de8+4N5DHvZtm97x9Ar6gFHR03
X-Microsoft-Antispam-PRVS: <DM5PR07MB3500CAA50D4C7B613C2CB8D097FC0@DM5PR07MB3500.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123555025)(20161123558100)(20161123560025)(20161123562025)(6072148);SRVR:DM5PR07MB3500;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3500;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;4:RUQE97KscKjBH9yiHt4lsq6WIbgWBCwikDdIKH+UfbgnW5Its8+1O/NAfAkqsBhd+OUmAhbrZNb0Eaw2gTHbX0h5KwECD7SkEqPHKq//LGAf40ih3G+OSKIni9g4kilsDfIXyPr7r8P4STrFRFb7KQGFu0b1LlOgre4recvMl4oDAnLJth4V4bLbY8a1MLqtzWAl1d2azJzh/xleblisec3CngY4bz00xCCMebv9ebao6E/a5wAuP51C7fD5KHXM/5DCFfw7oIOIMgQte6VLdIGZflRQL7gBnSTXRB/kZrS/kx6qumgeV+MHpwZE2IoGWJCyjPLgSVj6z1EJ1VstXtEaecTYiQx7O0AVfoKP3YrF69JeroekwiOQsRfX5OLjU8u1eGUNx7X+CI6Uv4Uqi6VeX6sg+cLjbwvjAEDNI5wIlQN84Fo2a9++oINsR+02CGeO6f1/CErhXmhqOd8UuprCnx5hjiL00pKq6bMlYSn7CGoZ9aiKjotyUgawVR3aCNOavZDwHzSTSbK8zsSVBIYt0iN40cpNRS6A8cW1sSzr5EVZdPS1qwIWhx3jMX8Jnle1Z9QxyzmH/19PJOcD6qAm2Zwr6Qex2HLgASb2EntzYniFzUSvKdbgeRMi3WkEPyLy6waRzCrmaapsdy4xGMdaCimb/y+Tjz/dqIbgW6I8gNYWA8ojz2iqwI9mmF0x9fb8PfrhyNXukdT7fhSZ2Ov5NCDsipTGFIbUGHtJMl+9DA2qmBSsgidR1CtpMQKLGfZ+b8iYLwWY0629BBsNkwHNxab4CzLHIkK6Ygd5A8o=
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39450400003)(39400400002)(39840400002)(39410400002)(39850400002)(305945005)(3846002)(5660300001)(7736002)(2906002)(53936002)(6512007)(25786009)(189998001)(478600001)(1076002)(107886003)(38730400002)(72206003)(81166006)(5003940100001)(6666003)(66066001)(47776003)(50466002)(8676002)(50226002)(42186005)(76176999)(53416004)(50986999)(6506006)(86362001)(33646002)(2950100002)(4326008)(36756003)(6486002)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3500;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3500;23:PkngFQb+S+SDaccoE9cI6CXdLIppCdL1MeXyr3xq7?=
 =?us-ascii?Q?+5cR7Kgt8iMdQJNWeiI+03ZeBTx9xCbkmpsoe32adtc6I9H4GGnFrrYhR94w?=
 =?us-ascii?Q?rbArW3iBCzDsU2U/QI4SaVfV4YgX+os8h6CS9Um/ZmJ9l4bEF94Of2QLz0sh?=
 =?us-ascii?Q?IYOSSCFZwSKa6a6W4aHShHev2NqhVuitAejei7QLT8lyYR25v7v6sL1aANZC?=
 =?us-ascii?Q?OM8bQD6KWXGaJV92T1WPhrOHUQ+GvtrCMUFRcEmeKrf/GAPfdLJNrM1nsx0D?=
 =?us-ascii?Q?nCQ6tCzr3crAu4O+KWe7q34OFHZuIq5Gk4bmj48E6UfQrGU+lQqjXDl3XXPe?=
 =?us-ascii?Q?Xay8vPzMVsQ3lCRf3arDT4sWDep0vOkWdGVrdGgXbiJyD4sipaETrIFz042h?=
 =?us-ascii?Q?f3fDK9ko8ASF/UjMAUYqWdlDB6kkTgvFazHnZaZoG3AT6rbj5/9gwSmLVSu9?=
 =?us-ascii?Q?8yY+KawBIwLMg3VEyZAJKZ85gqsBhbWxPxc8bvHohkH6IN733SiKyPsoTKXn?=
 =?us-ascii?Q?gvW4bmPGO0pgnnF6iF2TfllRFcm5Yf1uqTnBa7Zvw7T9Sj3MhdPns5hXX48E?=
 =?us-ascii?Q?StDPF5gPW4H5LdI3O+26mn92w0dQ9sWFkpo1zJbhdwHvD6vXR07tWAsqDHLr?=
 =?us-ascii?Q?46JveQL7TSztTmJO/XvHLBj/OMC/Gnzf8K3TbPPKmvvwf8N48gSwUUOL73UD?=
 =?us-ascii?Q?5/J4ndZ1hQ5asbm6uGsUlMvXopzm2kX1XFxcsiqb3rzky+ymI7NXaihTt05S?=
 =?us-ascii?Q?lluOKhE1nHztm69WjyL11VmtAVIrRCfg/PYagTG0Jt5FIL15Tyey8HbvIifN?=
 =?us-ascii?Q?vUoCp/OQo8Y/RiZEqxkYXSYYYDo+MIWH+l/OXotj1mrN1iWwLiTJjDZmmIYy?=
 =?us-ascii?Q?W8BX9YXuTWDnGQ9vK4VqKwEkKeBkTVc4g/NVXuzdD9W6MaGSKfL97sgufWCO?=
 =?us-ascii?Q?csXOFKcGUROaPxQGL7N9LcC1HV+grV48DRzMSTxZTT6UhfEAafeUF2LgYCKO?=
 =?us-ascii?Q?Pm08ul59qljYlx1cVK++vM6mhoopgeQFQUnICnXYyvP8GGbIX0W8kyw/gdb8?=
 =?us-ascii?Q?gbRmIY=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;6:8XIlGQ59G13q67/Y2pNiVmfsxb4xbkY0RUpFx1PPCv4fmCqQnv9JR+HPr7VyEsDZNqHOxmazpsK57pGYTUX9LzhcUZ8GfNAlXO0kEHgd9WmBy8az7wRBjpbovNPcHXPbS1rda7FYOHiWR/ab5FFk69iPj3N9gPyYGffxfvHLdNwzpq2vvV2ElhXQJ6Py8VsaoyaQAQ6RBbhmp4VXTZfZcFxLb9wZx+eYy582OrNAwTQkjEuwuUVg5Gp75XSnIT1IlggZu/DEDuT1SvA4+VtHPkjKb6wJIASCII++jPxbCjoGkNWCwDEIIW4tla0xpN3vEbE6Nf7kpBeHvdbHOfvWAVmSFd7aTukSTauD0Nub42F0h3q634cSdQDzkUqCJHYJJJMNMjYTMHPtNJPs5siA1QQRd45Ulkl0oG5XwG7z7aa15yfngQm955SubZjfzFzY2dCosAefwjaL3uKXQhbYYLH5lyRGBQawlz/FcqjQPBWY8/Wajh/hQalt9jO5LKA5A4cnJB4C+58kcQjATyZHCQ==;5:uGAH5zo5KQg6Cw2DvhNJu6xV7NdK1wvRouYSXnOcgEvoTNGu86RDC7My2DsKpgwND4MTrQqi139/z3UbU8opHge3tt82TnZY2ZfyD6I/zxlusbcixQeqb+j+oEnTkkEc2ppcQ1wqgsGWLD/aRD/QiKprkqHZMm6/hlXYe4VW4c8=;24:z2zHFA8FkQNERn2vCgA1WX2f3PuqDmhUA7u8ebvAMiAzu4ScuP4Y5PPdcOEaarzo9frZ0oLuCw3+w26MoRjnVeVptHjrPUCu6O6anzCnc+k=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;7:FH2cb0WQE+Svqm2ygCTrdLAWap2tS6JMd5mryM1txrmkH63gBQye5rBUOW3fjy//h1L/P/Cdg5xzfM4JQJtu4O/viheKgXL1nthnbL1FZdzlQrFozZkKEsQJYwig/LXyFxqaWd6Lz27k7CU1/hL9T9LSoMCzGjyn0VcSopTZrQ+CxAtAIaHFc6D2r1iY+cbK7lRX3gW9upEFqLjblz098OAfGAMMn7D+xlVjOfjbmjv00tl9ffd26tY5T1zGjQUuWOnIEEG5P7SjjQFRDPGFWc3E248ueqiWS17SyodXH6d80W5Uw62TkovkpCDqI4XirL7dW6LEKc+LIqosvyDmrg==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2017 00:38:32.0441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3500
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

DSHD was incorrectly classified as being BSHFL, and DSHD was missing
altogether.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/uapi/asm/inst.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index b5e46ae..e5f5385 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -276,12 +276,19 @@ enum lx_func {
  */
 enum bshfl_func {
 	wsbh_op = 0x2,
-	dshd_op = 0x5,
 	seb_op  = 0x10,
 	seh_op  = 0x18,
 };
 
 /*
+ * DBSHFL opcodes
+ */
+enum dbshfl_func {
+	dsbh_op = 0x2,
+	dshd_op = 0x5,
+};
+
+/*
  * MSA minor opcodes.
  */
 enum msa_func {
-- 
2.9.4
