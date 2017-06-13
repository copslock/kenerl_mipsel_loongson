Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jun 2017 00:30:41 +0200 (CEST)
Received: from mail-by2nam03on0078.outbound.protection.outlook.com ([104.47.42.78]:23616
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994628AbdFMW3Bo4y4u (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Jun 2017 00:29:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ZPYbnZSjTNP1HXvx0RYTBn1GR0QmdlPGge2MJOK/4oI=;
 b=MnemvkM2xXHDf5bOXEc5LdZbg0nj8k8HMB+wX1kiKRNfZmIBCvVE7uggkxf+pQ1KLmvPwcBjOXtI3c4jvUBdsi1xrAdEnTlIupu9UweJNzdI0ZFmPZF7v2Zy3qO8s+uv1Ur9XtSxmsQLePf1oZUz5eTrb/cdk2e/yX0nNfAyAx8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1157.12; Tue, 13 Jun 2017 22:28:55 +0000
From:   David Daney <david.daney@cavium.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 5/5] MIPS: Give __secure_computing() access to syscall arguments.
Date:   Tue, 13 Jun 2017 15:28:47 -0700
Message-Id: <20170613222847.7122-6-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20170613222847.7122-1-david.daney@cavium.com>
References: <20170613222847.7122-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0048.namprd07.prod.outlook.com (10.174.192.16) To
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR07MB3496:
X-MS-Office365-Filtering-Correlation-Id: 0678ed37-eced-4fef-1b4f-08d4b2ab93e4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;3:ginivR0uuFVNlv/pkrHxjd5LZjvu5bgvsIg3aAOCK0Tf0liGkaWyTwjnkyQ4eturoJMqV0IBMZItQ4wGzmPLTopiV1qwgcir3GkQ+4R0cUczD4h7p6eluBNZexU12OILeTe+o8SbEXxX4/mrq7IZ03Pzilu7D+6ufmhej9vqT+24qru8ShOJIwHoaK79lwH6031HZjmCBcFIXnPS8/T7O9OKJH6p6Qf4HIljD6mXF8E5kvKf4zyMSIZ8yPjMVFWDgBMUDRveWI5v0hR++/k7P4u/t0QbKcxpxShLugpglcN3RWE3Qw7dPjMRe8hzbwOBDY+CeqXzo1aGQh32Ylwnww==;25:aY+8ZWs1ev3Ge3q74x/AH2FlHRpFwrFH64rkwM5HO6vhWyBGhqlhUzzSDZuIT25x2KDFPOG0VBxDwMjDQ+CwXZSkOFFfakwL7YCdEvS3L7FJ3v7B2Oi9EectQd+hsibPa3oyuNxtRqensJUGmgl/Xtnm2wD12JujwLTqxkRDCBf58vidYF8flwEABIImnslMRlB0pqEQbOkM4jYJbpFV2ZKHoG1HSZH7KY8lCL5nLrTw+kzRTOUZ7CX3e+8daO8mhB+knVWbVWERBveAT+ACjxDlPWxmj7X2FaDp4kO6n5ZvmodSTKQ4rkNoEgf58re2QLebZR1u8r0QL3vKLGSy28nJhynxAxcWDUYI9OehKEKTt0cwpCByLB8YbXwR8ZnCLaWDzHO4ZFvaP+vNDjVbZgpuBp9SFSCGPznHrwReqw9atba2ozaeX7QYl0w2FPYYNzoGsAhaproCV8LBfk3xx7ZIERFsmeQV0CBXyeKPL1M=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;31:74jkQSHPjNEWwqPZR4HtydP+cq676VdjBkSZpwdhyGWhUUEK9kpL5YI1wClBg7yqGheQj57NjegTtfCOIAnFz+lJT6JUCJ96bhZbt8dedXwxUhACCME2GHaoWeuFR08OhPMzQzDbFajLUEddc8w55JvcFYk5vyavDdIljhq9sxATZiH0iQdQ8dsru+sn68OwPADcg1UUPi7l/KVauzxgbBzl/c/wfagdaz75aW1MQyw=;20:dkvLIRdaw4PhLwsMY8wgpfOtqubfuHafUB6I0CXEPtnk0zSrbqS+x7GgoImxnErRtuBiTNJeSxLXDsdUd400kWYqGNckZQO4b6ZC29D4Ox1FzeRceQff0G0buqa+4OMWSFAl3kW9dzd1iNOoJlfVjoTAQWszVvH0CvrFYI3vcJcSptaLIkt8iEKN+LrQ6FjfFedRlPI3tV5WxN7cSos6u2Z1P86hRUfpKEHeG1O6rLy7vzoXXy6ImJehOKnBBSsEdH8uprmFwo6t0QpnUNmJhMaG4KRFaSZL/PXseaA07ebamvCQkYERbLI4IDzHgaSxKV6F9wZXkQrK0YIui8KxJwxdHf75obHCrlJiSNOtQkMd24oK7vI+LF2DAuEfpYTZh/PyNxo6PHp/VQHoFCjB43+C0wYZXsdv2Bghay9HxU5X8v1zzl7yVmo3qBdEkpaNp8kyU48w6WyOn/inq0aN9KTgDtjJOZ6NV0nwU9pATacWN55KazkEAcrGJpt8J8tn
X-Microsoft-Antispam-PRVS: <CY4PR07MB3496DF119813AFF6CB5FDEB097C20@CY4PR07MB3496.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(100000703101)(100105400095)(93006095)(93001095)(6041248)(20161123555025)(20161123558100)(20161123562025)(20161123564025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3496;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3496;4:cXmxc7k3DCw76mJRyHZ1TLft3nwqiVF39C5A7xb3Ef?=
 =?us-ascii?Q?0oiDO2i5wN/EiO6P01u4KBmDdwRFZnlQwTFnJlYbtHxqKgjRSvwTks5zd9+U?=
 =?us-ascii?Q?3PhPsvscUZ8hoQ3EcCl0nXQxNlpubmts/zHRjECBuOSY4QpieSWWa7ztWIU/?=
 =?us-ascii?Q?8oB0yA8f2L/hOJWMiT4E/+aberqKvFKw1VqH5h3P8e/JVx3qKMrp08DzIaUg?=
 =?us-ascii?Q?EPV91bU3G4zKSiHS23Eb3rcgePOFMNCudNdWQx62IN+/5gwndr1PA99ZJKRE?=
 =?us-ascii?Q?VWjZKGY3eq6VelqFCsSOLCqRPM8KnEyV4f6nKcCnvZAUsPzrDi8elfBNIT5U?=
 =?us-ascii?Q?YYPfO5m+4ugPSUKFmMSZ0obbOvuIO+K4YykaYvCfeh1PEn2tkZGtQzJhnnbo?=
 =?us-ascii?Q?k5bZGXz5rgRIhSnBOzoNdUREW/gObKy2I9xH6sBu3db4CX6QU4ZFs9Zz1K4i?=
 =?us-ascii?Q?Q3A9lPDySLMkQqZqJ4MNN+vDMoxRWJGIkbaSg1CdV52KLL2BVjXfPVLeUN+Y?=
 =?us-ascii?Q?OXI5KsuZ3FxID+5DczvelU+/elkfR4I7MVaqlon3+3V8CzrXfNlO97LW6DOJ?=
 =?us-ascii?Q?AEIv791XQjHP6cTGLvmzq8s9DnolIyMI5EV+wu6n2o9V7q2o/IHYlc7htJbo?=
 =?us-ascii?Q?q/r1IXr6S17dvM5BYeIEgMlgEwRgfw2lXA+1kONBBNFVF9T9cRY84wCwTXyK?=
 =?us-ascii?Q?YdQDJ6jBvMZVx8CNRaVdoyAf6QtmlpKT/Tu/DmCJqQt1kHHN1yiwyBZ1VL32?=
 =?us-ascii?Q?WZOvUghwXm0KDHzjO1kufkBOofdajxzuRf0QqDTPatZDwmLO6v0aEdsBaDIy?=
 =?us-ascii?Q?lazwWR5pBAldBzkt+AyT/qkEPBBz+EB+bJWdmoL/hai8v1RNwygSa86xGJde?=
 =?us-ascii?Q?csApcH77o0070Qjj3u8jL/ZWooCR47dZiRkNffUHsvb0YwzL46EswKDtZwz0?=
 =?us-ascii?Q?ajfWmbzxX9iQ82t3BMDaxZ5FsU7MjyYxd4ogOxuzjBH7dZqWmV6UZfxfJFJw?=
 =?us-ascii?Q?os2LHDqL9+kMtTUmx0DV6mSMxmqZ3lZCgpFZGDWmewCIOSNgzyaI5YcXGvuH?=
 =?us-ascii?Q?Uwg0lMSDNcy/kMiHJX8VGUSAFUFTxt2rEx0dwqxlYc/YYrVYNwEEEIpSEbmH?=
 =?us-ascii?Q?UbHBVWmcH70EjxTKu5dp4kYY2fd604?=
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39410400002)(39400400002)(39850400002)(39840400002)(39450400003)(199003)(189002)(6486002)(1076002)(6666003)(2950100002)(36756003)(6506006)(105586002)(53416004)(42186005)(33646002)(106356001)(101416001)(50466002)(48376002)(76176999)(50986999)(72206003)(6116002)(5003940100001)(3846002)(50226002)(305945005)(97736004)(7736002)(189998001)(81156014)(8676002)(68736007)(53936002)(86362001)(69596002)(38730400002)(4326008)(54906002)(47776003)(25786009)(6512007)(81166006)(5660300001)(66066001)(107886003)(478600001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3496;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3496;23:sXg7alPpJye/PkXP/0DB/YydbYKvuNyHWe+vbctnB?=
 =?us-ascii?Q?9bzSZ3fGuZbxIUVpzOa7P5uvicEkPPCNoc9i62K3AkykVy2tYZ+BKSlE+DFI?=
 =?us-ascii?Q?DtqaX95TgOK2pp0gam+k9M5EyuScMjmWXzR9G8aavtY1i9wjErLSCmmiDLEg?=
 =?us-ascii?Q?hf8najiREAwoG//Mg7RKfxg3T9w6IFUcHHeYHfkTtJbKNNNxlfrcH8u02NXS?=
 =?us-ascii?Q?b2E6Cq/+W88Q0eBLBR7+ieiViMV9qAuz1ZPbWntArsl2K/CciBnRYnUb5qJX?=
 =?us-ascii?Q?K7CeiC/+f3caQwhdRMNr47VsgxA4uToD/IUjvNlVWHnj6P09MTBrHGWvCGgF?=
 =?us-ascii?Q?XnhzLyfmWBdiBb+97IwzdlpioGIytng1tUEgYz5llrbbA6tyh7CapNDZ8j7/?=
 =?us-ascii?Q?GJJR5b2tUKOawGUpO4PL1BBIIAB8wUxVx0MHNybkXhaVWr6hS6vAXsXiEGYw?=
 =?us-ascii?Q?dRPlchePLlpCG/OfWyP5uqqg+d64N2uxSB/w92ACbCQFXkSOa1ghhad8Wmue?=
 =?us-ascii?Q?o+qqxyF+6S4ph9hk2/Acs6IvA2gCnI2JXBEitvUpv7XD4dsUZyBBQ8hzplSI?=
 =?us-ascii?Q?ig6vC+cgoWrXOWHtnuwHEyd2EIA9fe/4SgxQHFX2bg1x4pZUcyhcwzwHoasw?=
 =?us-ascii?Q?iz4smsBJXNuhRC0FNFpn/KFKbjVfcYIZay5273eNtSxxy+TDCe1AyKbMG9fb?=
 =?us-ascii?Q?1nU223RDxiWSDXCI/AaiD9uaGCHfm3XCxjm6YhnEWY9ijSLz0LARRWmC5uKH?=
 =?us-ascii?Q?ikSsXiglHdVNlQ7XakinoGuCEEzeFJOyXRuxlr+Q2n0VplcuP9bpTRfKp6k0?=
 =?us-ascii?Q?eSfQETJ9DRTGIqByNs8O018yLhD6BvHxZzaNckWNu/xQpla6hnrZeuF86nHs?=
 =?us-ascii?Q?HMhQIqTLSWbYXFePVJsQIfJe14RTg35YdUTFqtXOG98GW3Fc2dbvShX3Tl7l?=
 =?us-ascii?Q?yixUJDsAG358xvQwZTnMkxmi3VJu8LicVtVxUTyDd1R8S1SaSoTZ8LYe8PMe?=
 =?us-ascii?Q?7JUrXvUJM1mHEQbSPhi4SDvR/FLz6FfiR/2+yry1BBt/c2b52yNx8/zop/ck?=
 =?us-ascii?Q?A5eGrv8470VHfGcPC9lCtYbq4rMz1UVcAAo9n0e8Jo5q/eYPUeHXwT5M5KUC?=
 =?us-ascii?Q?y1476l8fZkLsV86md4FakhOofUGFkEqX1vMjCx55tzeStBh4iGVkDNUpscHp?=
 =?us-ascii?Q?poFm2o/eUdtO2iWPP/nHVaH99faqdT6lTZKWeuBiQ7+F6pv0uDX55e+HGhQt?=
 =?us-ascii?Q?FjYhQhBRkrfsJAGdXXQcDTTW3yidwIuew3K4hnb?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;6:cHNmB/ONDUnWYH0G4GxleXXeS4Pp8FmDnZB0MkHD5TGFhzOMYOZpZ2es1sfSd5i7V8Ir2Wgt86om1Yhz3cFDIQOzKmsFsDHIecShgsUpouBLTewZ3n9o18gXQngKRvXeO8e1Sw3e9odnM9WrlbKodt2lDdAI+eQ3v61IaUjgefaNw/VxSA3gGFPmG6hvZFma2MbiSurbRsZCxJsd3H41XhGUg4YdhliVAEl8KyAxbdQlewK2NPVdi9/Sulc0C+JB/bofenBofg3WIjJNZiorS1YIE482VmmX6HNnxuLXxmRmWbbMvf764AGfNrdjp+dEW92KzJJJXkCg+4ZvRcJgtwbRshNlsy5I4fmAaObjaE9kyyHMVmMBJbLDL9/O5TlgzgXfBdnWKrF+bFkytzJFE3Zp92BnSFVs+6Wxzn57/Jl9jdlDppVE/4lmpRSVC+CXsMvbeChp4emkFnwV1LlJIRi/aZwuQgn/OKrpRYV/XMUk27gz5PT9tB/VuGGg/1u6EwRzQC4rH/NE1ecKl1V7OQ==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;5:9MldG/YGIgaihWjLI1pQcwRoMINIw+9f+Bm/SbFfBxW+0emxPgoRbhv2IVN8//wnhaOW+3DxVhc8RpyJCJDi7g5L/EX3B3nsfY9cPDLP8xwVbbR8n5pSX7dE8z77ykT1dRV8P70Mfa1/toQzYPVv/FOx4pTNILcxAnhksZ7z+FWhVU/DdVPKXRG/Oy+QL9NPESnvrxzOJDRqwJ8IDBpIbPDX013k3ebL2FWIePBoMaz/lFBE4pk49XIHsdCkx8/3Ew7Qylq4B/gN3HMsaLeBpOGfdzXPDY6S8GHtubFeEFDOC04Ot3XzvzeCg8dttATVyThVBWrg2b42e86vlA5iwkunB2WTzZ8rRVnlV9CrnXsnY/QiKPmrvjiVza9gGKx4lh/n8l1vVlk290GkAXahgBkKGaFcKA5EEYirDkxZNPhn2IJn7K4qR8YuDSpkMXXeBo/VboANa3Hnn5FH1hlo1B8LQ5n7K1p6P1duTQPvVbuqJ3HQEi6UZs65b/z5sugZ;24:u4ftsDqZf87gnvOgpDu8aQC6mXQ+d3A+K+Dnmfccvn5xCbfr1OCVSs21gMvU/GK6fB76yXPFwQjEWimCMxnES24YybBX9Ae4OlCdG48u5xA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;7:x0o4VE12JgU7HPR6xSbsUx1DTL7zyj8TTIlYbxx1de4u38woBgs3OudC0Q2ZD2GUlY945cOgRZ3/R5ZkFldHbyohKMFafHoXH4d41KKXheQY+t8j6FHtTz+q6iTIw/ZImiDGYkDh/B37I53eCcCcb10PfPdxZKspmwwjaKmgQk4hpE8v3e2602AJ3J0iWmD5oPIa5rPZ26IFu+Py8FrrvnkCS4O3Mj+fDYuKnOEEr+RssQ6ipEQ8MlzO0P0h5XoGkaAmpv+s3qz5dmNgHgEWNH79CIXaN+rEO0OjylvuBd/bQDhrsAetKpoM5xK+mDUG1lhbDBkEXhdHOPSG9aAz1Q==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2017 22:28:55.1277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3496
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58430
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

KProbes of __seccomp_filter() are not very useful without access to
the syscall arguments.

Do what x86 does, and populate a struct seccomp_data to be passed to
__secure_computing().  This allows samples/bpf/tracex5 to extract a
sensible trace.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/kernel/ptrace.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 6931fe7..ba3b1f7 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -868,8 +868,26 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
 	    tracehook_report_syscall_entry(regs))
 		return -1;
 
-	if (secure_computing(NULL) == -1)
-		return -1;
+#ifdef CONFIG_SECCOMP
+	if (unlikely(test_thread_flag(TIF_SECCOMP))) {
+		int ret, i;
+		struct seccomp_data sd;
+
+		sd.nr = syscall;
+		sd.arch = syscall_get_arch();
+		for (i = 0; i < 6; i++) {
+			unsigned long v, r;
+
+			r = mips_get_syscall_arg(&v, current, regs, i);
+			sd.args[i] = r ? 0 : v;
+		}
+		sd.instruction_pointer = KSTK_EIP(current);
+
+		ret = __secure_computing(&sd);
+		if (ret == -1)
+			return ret;
+	}
+#endif
 
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->regs[2]);
-- 
2.9.4
