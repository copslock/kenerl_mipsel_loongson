Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2018 18:02:15 +0200 (CEST)
Received: from mail-eopbgr680090.outbound.protection.outlook.com ([40.107.68.90]:45312
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994649AbeIEQAWFH57O (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 Sep 2018 18:00:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0e+ApIacJJi6cqI1VyR8hxbCN76Ht+h9NY+z1h4FaA4=;
 b=b9R5yYWM9ZfAf2zqOtMzgXPUGl2jK+uqTKXPZTSaYY0E/aNxZmLuP1Yj6CxdPbfI59y7rk35Sq5rOSdgehibyttjMl2o3SW6xLk0cbS7c1IPKmUhp0LpO+gOkhS1qEKoBMbb0k58ysF9cjMth63/OsZc+AcLaGkuwrSh+SHniys=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from box.mipstec.com (4.16.204.77) by
 BN3PR0801MB2145.namprd08.prod.outlook.com (2a01:111:e400:7bb5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.18; Wed, 5 Sep
 2018 16:00:03 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, rachel.mozes@intel.com,
        Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH v4 5/6] MIPS: kexec: Relax memory restriction
Date:   Wed,  5 Sep 2018 08:59:08 -0700
Message-Id: <20180905155909.30454-6-dzhu@wavecomp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905155909.30454-1-dzhu@wavecomp.com>
References: <20180905155909.30454-1-dzhu@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR2001CA0003.namprd20.prod.outlook.com
 (2603:10b6:4:16::13) To BN3PR0801MB2145.namprd08.prod.outlook.com
 (2a01:111:e400:7bb5::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c717e4b-9e38-4ab9-5dec-08d61348a4ba
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN3PR0801MB2145;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;3:ZNvZi2T+9MAQJND+2wJE1+Td37dGjdCBUCLKe+fhu2xzKLH7KUc3FyxWCl89WjFlzhhUUTGQbCV69SL9UudiXdmVdeycIkaSQnsafIf61v6qBqleQEZF0dqgo7ggM3sGZaE2ukqCpL6IPHFX3paYQIiU7OP+ZkuczeZzKqtpayWVjMr2FvZ4BVBJ4SrjlVDjIQVv9BId6PkaZqTjW+Neh62tMZOUD3oRW8szhlBC1KAUyE42fnctHWBR3+/df4Wl;25:UEIbOJntElCVVQC4EAMFEDfwlDaCAUNZyfUSlB6ZTQgTowqVjVfnDzaEWXSQamIoI/VqgwIgsCsAHcWR0Yw/l7pdkcnyAIquPslFVGzy4rxddlSEnu9FsBW7Q5OtRAGWunXthJm4WKDwGleJhS9kTWRPzRjtujPfebLHFozazEfB5Gh6lkoo2F7Aw2mH+XN2edQlz/vIX+ksdJkkmX0T7BUWasTN4TpCEqRCyMZfNz7BjgPfBZLYEAicQ3P6UtTiKeNvjIEh99pHunbkFaAIJdutkn+fx8H5xwKewoqjVxAkJVx/d7ujg+Nd2wDRDPdhtckfU1GBYncJKlTO5wKjDg==;31:UI4Hgxdk+lA9/87Nrme7MLYmztagebLEoEvSfvJK4TvyiNZDxHdqhI2L3CTZ0P8c2Xs3gy3CL+wXwbIDe5GXC/mbZm//sIzERWBUYbSURQj1o4/4qyiZNqDTkKw71m0dExUlANN5lCdpHJkBchiwZKPvD841D4/BKre60EDdbH1S1NXMOJk/d3N7ptT+shf7oBulfkuj208/DCDt33Bc0w0JJ9DW57GLR9R6kKR7HVs=
X-MS-TrafficTypeDiagnostic: BN3PR0801MB2145:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;20:hzZxkKuuMyDTIzrb9rfClxlqpsqwoy7EAyZKLa/q+P9dGUqrYJQSYovp+Jk0/txY3Mj5eZOOj8Wr9eBE+kj10vh5kx5FN0PUYkVWXhyYSMlsx4ajgRrQJWWfv1am7Pqlaba3nh+W6tkpMX20EjtPMQp0e1kQcRSZG/OCLA00qxWyDaBeLfnK22Vc2aLa8i+cm2aMxVOcXPCF6/EYRGTN/+ZO5sm45SvIKFDXe6dXCYGTwl5Q7vLswbm5cROi7gYX;4:xH09KEBP1l9biLxvoZ9ju8pNjPFfaBIeXmsYH3q8n3CPWizv5SMbVVgK8A+x1l48Qik3/PxOMJ1l19GR7pjrzUb4RvJDgMtQpL7u/+9Lk3PxlhuEADtApds2EJdfdtHWcb4o1eUMWtcnNnN51KW1II9EVDvfiWrrS5nyDEcgrFgi6Eykxq32L5pxVgzUnjjK1h56/IjM6Gn4oTnwlt2iRBbvtyz9uAKDdPriByU5qpyjIYKancAKhnQRa1N3jADLYv/3GjxJ32KDWEdFlEj29ffiL9dFsq2rkB8NOlo0rSH8dfQG6VfHR8Vg6Th2qiOO
X-Microsoft-Antispam-PRVS: <BN3PR0801MB21459480F36EFF806AE98E71A2020@BN3PR0801MB2145.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:BN3PR0801MB2145;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0801MB2145;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(346002)(39840400004)(376002)(199004)(189003)(11346002)(956004)(476003)(446003)(486006)(16526019)(26005)(53936002)(6506007)(386003)(81156014)(81166006)(5660300001)(53416004)(14444005)(8676002)(2906002)(8936002)(25786009)(48376002)(106356001)(4326008)(51416003)(105586002)(50226002)(66066001)(47776003)(68736007)(107886003)(76176011)(50466002)(305945005)(2616005)(52116002)(7736002)(316002)(37156001)(86362001)(97736004)(69596002)(16586007)(1076002)(6512007)(6486002)(6116002)(36756003)(478600001)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0801MB2145;H:box.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR0801MB2145;23:ZpHZUQViJII6BTAYsVhFmSQVC26BoGa1v9+ETWB?=
 =?us-ascii?Q?3beVAK/R4ZRLrxHOlL8kPyjByPvJXwlIlNcQfG3Y0CMWFkJJGc10zio8ZSO6?=
 =?us-ascii?Q?rMNokf3jxEiIbIimynDAVL8NUsFhtpHvPJJmnXDtu+WyoJiRi9fn40vD+6Cf?=
 =?us-ascii?Q?7/r/6FrgnXeg+zdqteW3ybL2vUI5NY7miRLsxtBkofw6kRZKtbuAFGrt4P0z?=
 =?us-ascii?Q?3Mq5AT58YhLt4Xtm5H7wvefZf5GPD24dXzEdeH73qE16yEBsiMdSeAV4yDXo?=
 =?us-ascii?Q?QKo3wO/FBpJe8VgY+wMyRXTVlhBNGFpxAkZWcrpYCyfmyGL96ob4jTZKS3da?=
 =?us-ascii?Q?DFqIc6lV+p5u7nmvddBlmii9S133OqgBs5GY6LCwPjOLsxxWLWpB93MjPQPi?=
 =?us-ascii?Q?Iq84jUzq4o2wWL3OfHRYOp4Ikh/eHD/E/GKalH4Wb60RnroAY1LoiRnmRBdb?=
 =?us-ascii?Q?5GSzh9QP6zaWdvS84IndfuoUeFf4XUEP1/rlbzJdtNwh8eGZSCDp9iYEf08W?=
 =?us-ascii?Q?P7NRmOl8Dlc9ZNHMMs1kw4cQgTeIDdMoHgYljP1N4hHDYUWxjNbJKAc7on2O?=
 =?us-ascii?Q?kQsTw3ocb5sUNB5ebOdzCIW0MQW7DCgaQYWbJMQSgBIFqjLzsSnzxYiHWJVT?=
 =?us-ascii?Q?HwxG0iQLxEzSb4bW+pomV8vLEO+nxOrAr4aZR8DHS3x6dfuI96nRv9oXVna9?=
 =?us-ascii?Q?3RvXn4pNJ2AKU98UUGrJzTwJF/h0125TClssfm5+XowsNUqjq8+fm7FdwFrb?=
 =?us-ascii?Q?yQl9g6FpwnWj9/nDTS80BZE59dEUOzvdzZeWV/EM7m4olzlfzDSWgoEWZrjO?=
 =?us-ascii?Q?GjHs1AIpqLYuD+SwgM+qmI14Co7bnh6Ihh/UG9g783Tw/GkljEA44EcnrScN?=
 =?us-ascii?Q?cp4lsXMWcmCzcT4S6WyX59lxverA2oVe2T1uJmo60y/LdDO9r5LDR+onJBoa?=
 =?us-ascii?Q?jV+F7/A0ucIPns/H6kwbv6XrER/70MqfSX1dWq/8NedwOxC+hrc/wQORYMbe?=
 =?us-ascii?Q?RaumJ59/IxEzUPIkT3Jgtpflog3gXHqZczMEG/xNN7NwtRD6t3src329Wg27?=
 =?us-ascii?Q?1Gt4MyirnhF/x9BOUcLYKNU0GIvH4XWo1IKX1Kw9W8XNilOI43L8S6CgoJww?=
 =?us-ascii?Q?CExyc3BOBiC2mIH750eqcKJ3LDJQOHKsO/R4hx0gQtanmJ8YHWzzPA3HjlCm?=
 =?us-ascii?Q?xgGd3nUC+UED62OzbMRYNn4gq0asM963rHcO6ePHwvEyN2aLEbOq1QzZfTQ?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: N8qqMJUwjI6OYItOBU/MXajmlSkZ98LDY4iBMRzIXI+Z4WH8WYBeGx2cxwnmDpkozFzMvHfA8w4PVCGPS1S0jBdXK+tfypnNH26HzcrCuAyItv+aHi/eoLaeIZl2qelJUrNd09UFaUksgZd8Mn1w2uhiO5HzD/sNa9j1ME/dQTQKY9IBxDgyIBZyxO0GJiwRxUgDKNFIYBfag8jTdovSPBFGdk2vC7KXS1P/PrjZ2rFKsNxQMVz0JUmb5b5WhZ8g/IE5SE3O/lK1ii8DoTTZX5TayZBSdLkvVXWamsx+3z5fuu8xtHnXL1uAyv4M/mt9QVHVS7jS5ijaUVBgikFzniLg+EhxSdLrXSvaL3ZnaGg=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;6:dTBfQ3Y7EwxkQAugkHBUl0W4f4298hm9Hz2j1WrsIFzIhDWZ6puhjXf0Hut/tQS+PXMojmYpg3gji0luQz68ZYgNIc/ro/otLUcKyTw9hAjSGJwXlW1tvrX0SrSIyqMVmZlSb+H0+luaUBbdphIQ3kmZDE5hp+e95qSqdl+IzAV4iA2TRwR7hZbJR8gu7oRKX3uOHhTSlFen+rlXodDV2IHrAW3p7X27G1YYS70HMUS34u6eogscDSvQgZ5rBip70McR3Xg0Ap3UWsbdx5Y46JugTPhV2AOWCYGj26ThLxPbgscbV57voR49iKQzdKGnol7H1cGXrjgFyerWwO/RXznPvOslwQA2tuoFkJdjFdNBw3akm4vqBfOpE4W7BCeiWvdj87qo/DhYk6xeO1UEpskjLrpDldy08l6Bvgvy4qgD3Mvxo/8+WcrrRBtdqrF+NJjkEEn/Sdm4rqtLII+KIw==;5:Gs80jnIQ6bp835K/xz7G0DTksp8D0GZ7QiivsLu6i4f8FZVElbj/lteNslkt/Xi9xbpQEISskHtESVtMiF+7uNbeAtqsOiUAYy4rsRfC0yPu8i47qQqDioI01zASkGVTbtU5p3HgByK+r7hgecO+jnvqL4Gx/tzwnwcspP9wdbQ=;7:k/wmvq6R9KX1jVNr7nK1jdeNdsTY/BnlivSfYS+wyWR4jncXjR2+RiWhVEcB5BKUIJ+8vSf3E9kV3XWIVxQ7LpD0aGZVCre5VZaOwajHlC15rz7Drfe7fiIcxa95rprYb4bpiyJ1tG1xvhBWy5JM+RCfQw41rnhVt2ofW9UIJ+gOGr+Wi9jgqRTlkc7y9cl/E4wxBMuEhTjDtGCI54Vc2gQwOWYHfqmI6jRB8z6drWcjQNuP7ZUMoTNpZNkNqM5T
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 16:00:03.4722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c717e4b-9e38-4ab9-5dec-08d61348a4ba
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0801MB2145
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dzhu@wavecomp.com
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

We can rely on the system kernel and the dump capture kernel themselves in
memory usage.

Being restrictive with 512MB limit may cause kexec tool failure on some
platforms.

Tested-by: Rachel Mozes <rachel.mozes@intel.com>
Reported-by: Rachel Mozes <rachel.mozes@intel.com>
Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
---
 arch/mips/include/asm/kexec.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/kexec.h b/arch/mips/include/asm/kexec.h
index 33f31a8bd8d3..2583e6a201e3 100644
--- a/arch/mips/include/asm/kexec.h
+++ b/arch/mips/include/asm/kexec.h
@@ -12,11 +12,11 @@
 #include <asm/stacktrace.h>
 
 /* Maximum physical address we can use pages from */
-#define KEXEC_SOURCE_MEMORY_LIMIT (0x20000000)
+#define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
 /* Maximum address we can reach in physical address mode */
-#define KEXEC_DESTINATION_MEMORY_LIMIT (0x20000000)
+#define KEXEC_DESTINATION_MEMORY_LIMIT (-1UL)
  /* Maximum address we can use for the control code buffer */
-#define KEXEC_CONTROL_MEMORY_LIMIT (0x20000000)
+#define KEXEC_CONTROL_MEMORY_LIMIT (-1UL)
 /* Reserve 3*4096 bytes for board-specific info */
 #define KEXEC_CONTROL_PAGE_SIZE (4096 + 3*4096)
 
-- 
2.17.1
