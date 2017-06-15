Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 00:37:11 +0200 (CEST)
Received: from mail-by2nam03on0075.outbound.protection.outlook.com ([104.47.42.75]:37054
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994790AbdFOWf6k3TIr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 16 Jun 2017 00:35:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3hw4XT88E2gSCITk0MoOCs6JjiuMNbNcroMJVBx8urU=;
 b=ORGsC0iDAAXOFFJxz/52L9J7vUuJ8UCmlPOZ6qQdG2jg6rRCJrmCpdvlBix5In1BV9uqmw2gSnrm8UH2BinhQmc/Ps1PV4tpdT4FWrmBUXEs/IcrxFiVxN7g/cZCWI98A0gK6reg79XNCY0WjXWJDH4pN2UJBvHWDp7xaDQ/lrY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cavium.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3501.namprd07.prod.outlook.com (10.164.192.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1157.12; Thu, 15 Jun 2017 22:35:49 +0000
From:   David Daney <david.daney@cavium.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH RFC 3/3] MIPS: Include file changes to enable building BPF code with llvm
Date:   Thu, 15 Jun 2017 15:35:43 -0700
Message-Id: <20170615223543.22867-4-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20170615223543.22867-1-david.daney@cavium.com>
References: <20170615223543.22867-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0070.namprd07.prod.outlook.com (10.174.192.38) To
 MWHPR07MB3501.namprd07.prod.outlook.com (10.164.192.28)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR07MB3501:
X-MS-Office365-Filtering-Correlation-Id: 1f4ea946-53a7-4003-5c02-08d4b43edf67
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:MWHPR07MB3501;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;3:1dMIW9B4zfQt9yeduZWjHq5LD6NmcOuhsYonm+SM9g3bJ6dlQybygJ2KVyybc0pDETXsVff9m0m9T4PoSQjuQdJZfbjMSEnJRcjnH0CiUCYTY8Q/xwFEl4zwQX8jGrHSFztjGUHQGDWWyRXoh/drbX0Jd9A4p+vZTj+TWu1t1gWLEOd09iIZSQnHhjxBQxXLDT10F2Qcb3t7wHqDNI/IwOBZAl56mp+AZIZAr/WXHAtSoxHy2/dfwGIjkK58NkTxOc1PGpsF576/yxZH3+z1auuKF3FFBW3ylkNhaRK7/FTKo1AL4A8TbBPAfx9FY0FkJ03hQx5Qhsz6bd+s6rvRmg==;25:wQKwhYI+fHxXVW4Na88q/XGb5Z8cId/IbzEC73Mjj3DVZWzZye5h3FJNK9lldoOKMwmyODRhckfosn/7WVFmanxvXUoeyOfbGgSnt/iZ/117R5QTcMECT4QOTBqaQTeWz/Ni3urhi3ZCiRpOdTVN5rjG1mmLSks0mYAUrltKogJQ6YA+Pu/GRmst2Fk8904WAjuI59Q7LTOLvv8ux0r6vpkHKQ5ezKLvj91Q9FQEyPpGrVeW9wsTFNpN1aJjvScVUwEvXjZemTM+mSh+KU+QAh0kC0ZjVsUxAoobuNAiS+pK3PWK0Pk+ObSU0k9/2BQ6JANFDrg3PypkuecrqLB8Ro306OaXhArL8vcXuTU5HQXTSKZegYmoZO2zgMMX+hSMZNaG1eOTOZieBao6I5P6WgrUZq5VE9UsNSpwKA0Jpq3aLKfmSzxAy4utE777FEuVRK/qL2dgz2dOe+iaUt/jm79fl96K3y5XZsqQ95fu7e0=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;31:kZJyrftkmkoA5bl1FlGvmAX/lJHv9gNIaUEVHV0l0pBiqR3wllGodH970h6/JfTrYO+V6aQVwiUwcqOYD/cMvdmS3Oiib120WM8wq9NCD1EMSKVVvW9yFJrr+VI0JdqmD2Run9KaUcXPb/pLbwlC7nwOuknvyKEoxhYcGRw2QMC7aFLBcGgzXCTkSMLC/8nfWyKdN5CT1sjxDbZQ+HeNlc8G6hbVXkP0r0T+6XDVBpU=;20:f2ArqkISJaGpt3Bnrtrn5W+WkzZPqUKAQF6ORIeIiUFzLr5qIyl0VOCxZ9BFZ0p/zhkbHB/n4LQuQiL08U+qJAiFFx3BDdwcubNgIwujpQj1yYhjP9/RXHcxA9eSGBtBcjVy3OmLDF1XBoqOJPLlfEeRY4tknZCQpi3e5SgrLfqu95GOjJEaE0dyu1HJinXKoDzbPu8n4JRv5Y4XCil2hKUBYaKpe/dBnVNAgXNbmeb6KOI+Rm0ET2qj37QUxneaqPa9NWYM9RqYMoLbFM/JGN2qZOFFf69ZHYBcaox9xfaUuBkqx0FUwzgq1yBmU2YFiP6EXfnHiO5HMb1Jft27QQuCqywd0yDUnfVoxKWbScYA3RNlwTy3oKcoD4Ta+zUwsRf0EczgiqPf7eCdjPp1GGGXfDRUZ4OaqcIq6BZsGJo92MUhPlYIEkP0Zl8toIRQV5uGydVFW78dNhiOKhIyu6V0f8kPBUERRA7mojTH4l6CfbKYYspcmZcz7tCMSlT9
X-Microsoft-Antispam-PRVS: <MWHPR07MB3501E6D961F2202805220B8D97C00@MWHPR07MB3501.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(100000703101)(100105400095)(3002001)(6041248)(20161123558100)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123555025)(20161123562025)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR07MB3501;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR07MB3501;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3501;4:T55vB+HWCVuTJB6lpZmFu9cQoBY1XtY/9K8zNa0O4u?=
 =?us-ascii?Q?M5gmDeQ47MwHZlHFt8OeAb65PvqPewBfApRAnqn1g4DjVs8SZ59E7SrwjxT7?=
 =?us-ascii?Q?HG0c40lHs3FEhmQYe7gpJY+NUrBvFCVGGkKffoHj5M5L/WhNyEzV+OM/XZz+?=
 =?us-ascii?Q?d7BMv1DmU6hcqGWIt20YvhLau/3vYFtoLVSt1cjx55yUe7s4NRdDRc+7NmM9?=
 =?us-ascii?Q?H4p56ODv/SL28FtvnK8lUNw/pttnmerWjdCqP7OmaD9RCbdgjOtAp8otPBig?=
 =?us-ascii?Q?cQ9ZBz6jK6r4+XGu/SDJm7V+vO0XprwOd7rHvrHDmQYjzWRJfvaO2CcBpJlV?=
 =?us-ascii?Q?rRHJxlXeIK7vU0vuYnbEI2cRvcxkVGk49ojYK+yj1+th3t/Eme+oJ8mDMvtU?=
 =?us-ascii?Q?EVY1HLC+30u70pGPmTSZnsxvOKlR9dIGs63FJf6H3GNAkGJSRF7Wf3Ul361M?=
 =?us-ascii?Q?VJbn8hsZ2qzgGI+C3ZD6acrbVzZbeU2Qb2h2J66x1K/fQyzcDOhYBien2mCy?=
 =?us-ascii?Q?cG1ESF4B/KvTZS2XCV/rzBBn30bvNqxMNrdMle0qiHAned/G6Qm4QbXbvaLu?=
 =?us-ascii?Q?0y/SDYnsXhn0/5fAUHtRDv5MH5okyyNvHma8DnCgpppTyQD1Q+PZ4jONcVfZ?=
 =?us-ascii?Q?B+z26EpAJY+ZzsYR7qNGQSGcVgu2ruzqYsw+CbQHolpkyY4MyU8HCy+SySKb?=
 =?us-ascii?Q?dFx3A6iFcG9oW3NahpdnDv2jpxKSSaWqZl1cAuUWaY5vqHE0QFev1mD4erPd?=
 =?us-ascii?Q?ZdyT0NWUEstGEBxdI02otdZ7rOAtTI27qeV8XF2jpyO5bIz9XDkNbFOaboeW?=
 =?us-ascii?Q?4GT9lwcbX3RANPUt9bkk1M3vVXNCWSgWgVse+JAs7q2eCeJfIIOiJY+lYzim?=
 =?us-ascii?Q?uhG9Modbokx4YdcZz5Yx7xj8/X3frwgY2O6H0hNQHJkstSm1M1al/iyBz/WK?=
 =?us-ascii?Q?VuQPmKF/wnAUJYk/xzy4SipTvTkzGC8k+oNOvYqfevJV06sg7W8f4x3GaL5m?=
 =?us-ascii?Q?/u+FnNM920uLUvxz6P0InmfnE2PGX/JqsqISHTifYVVzgtrktQz5Uany4Cbw?=
 =?us-ascii?Q?/0+Yyp/R90kjJeltILL7uwymzlgskFebS3N1l/IDvGPR36Q013hg25aBXuJS?=
 =?us-ascii?Q?UclRRkGNxFizghkT1GepJFvD7Yih3C?=
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39400400002)(39850400002)(39410400002)(39450400003)(39860400002)(39840400002)(81166006)(72206003)(8676002)(47776003)(1076002)(7736002)(305945005)(76176999)(6116002)(50986999)(86362001)(5660300001)(2906002)(36756003)(3846002)(38730400002)(66066001)(2950100002)(53416004)(6506006)(189998001)(478600001)(107886003)(4326008)(6512007)(5003940100001)(42186005)(33646002)(6486002)(50466002)(53936002)(48376002)(25786009)(50226002)(6666003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3501;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3501;23:4a6oLjuT9v+y+T6qbZ1igTOHVXgmbXRj1zMqkeD6b?=
 =?us-ascii?Q?s4Nwkzu6/pAMXqzFECiOG0D3PhKIg9oRBL0FMrsP1/oF8/623c6pwTLF3ocF?=
 =?us-ascii?Q?I/71Sa234hALrb/5QtKsahmnFB6zWfJQa3A9+wxFN2oLZhUwnSM5+fkNRCL2?=
 =?us-ascii?Q?dwNZ43o/SwcVPDYSDlXoGrX2kbiJdSW1VmK3vvBo6TOJ553kPrNwRRj7ORFh?=
 =?us-ascii?Q?kfkG0FEpDxRxLFLmGNjpyIBv3DCwML7sqj7VD0A1vhC2nkhZXyjugGL0ZQXx?=
 =?us-ascii?Q?RFs6tdveQHQoJFqCo4K39EDjEp4R5QoBljXsee4wTInzm6jJ8PLrC4U9AQLf?=
 =?us-ascii?Q?SgUwCCnyAOCL5SbhJocSkRT+tbWC48ZCsKWyTzfs1SSPdwDxdV8hiWaM1i5T?=
 =?us-ascii?Q?i5K0pgoNUtEQWLGQvOgvC7jspvFJEaMtvTgOXsQJhXu8sNjjAv1ZD6lK1Phs?=
 =?us-ascii?Q?ni3ZsXNydtBokplWxUJjUbAotaHuLkwn4xpq5Xy+RpijcXLSsLEor4JU+VBG?=
 =?us-ascii?Q?q4KRkM2RfW6/iYiZ55eiW7oHr3dY12hNkgfqnxreJAE42s1gSRIrm3lHX6qS?=
 =?us-ascii?Q?zJN/IHl/tXN9a6nWNn/CS2jmTmXXqdY+5Ev1Iiktg6aPOq3YvpvA0G7snb+t?=
 =?us-ascii?Q?pvBdVe50kru9VFD3kpjoFEnDvkDF7DBE7JAbt+z/prbAqjVxGft4HRHKstI3?=
 =?us-ascii?Q?b4L7kKNOyUIx7u5A+GVmLm4UZGS1Rg2t2Zt1NoVi973k1GR5N0ZKS1Rj8+5m?=
 =?us-ascii?Q?yOrR716KJao3hj7bdMfwjXSp/viRdQNm2UFvzI79rjHxwhxML5jtvHuL+TGa?=
 =?us-ascii?Q?1a1yh/E4AC24EqL3c0cMuEeL9JesVP3W5VK/XxX2RhEPnLIF6GOPpytUuTKf?=
 =?us-ascii?Q?96mGmBhe1Bt+t8oRHE7y2l/NtGOUkOX6Bc7woNlDr383HHqXmVo85qCSl+Uv?=
 =?us-ascii?Q?25bl+S8KgsPhloeYbZHaFE27SHbsfxstsyGG7un0VXDY66WWMP/YRTsOK2jw?=
 =?us-ascii?Q?gV04FhYKJNsZVtoU690OjkXOAvBw6yQ6EGZI4sq2nZR2opB/PjEE5WEhHl/g?=
 =?us-ascii?Q?iBgyuANubNYdPdxYr57MMYnpyJtQrBbo9tvnsn0LCe9CmXNDyaJupjGRyB83?=
 =?us-ascii?Q?ofFymMTWmI=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;6:jqIH7DF0WzXnbVHfPj3nEVWjbPab2BjKNGgKqyGOXvpgaOjikX0dJ+oTf5ITTUO5hWzPoC7TKB0PFjZizjEjaJeqMETb2tQEcmkMQrPdom4Y0npTVCLzIBwcMlwN3pH/sOd6NtO8b6xLMGrES/DKE2tt5KKh9wXfRcBZQIvg5ae0cnTj4aQOpoddVmpcPKh7C/s4dwqOfW+nIEKShsvHCD00a6qTXo7lmwAU+TqXFjLqM7gEPm+bD5qt6peB8sSvr6F55eli8ND/Ebwo5segC0cPTGWwiwGdHT/GEnQ+0rraXdN1d5i/M5EClgMw9G7lIkGvuSSNuxX7rzkZ7RgiajS0Gp+VAyKkx206h6xhz58rJTPQxMlcgiFqsR/3eXcg88wTB+L0ubYUurYz9MkcrPrfjhsQPmsBmiCz8ma2swQm+a3OWlVfrFBuwpDhSJpEwIjH6BKRBFmKfrxPRQznZgj8UEsh5lVtfnoIW8OfPFSoW4uyWOTe8sFOY4ECuwGbWdHUbzwOWDMkjj2lv2/nFg==
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;5:S/lYO2ugAFNiqm9i+F+NkWhJnhKwwxfC6My5FCPmSMVUl6Wb5rwMDMnTx1pOMcAG7XUcQlXuqhBmrKZXetOOtJmJYWY0XA96hwZKi6R1NtV+FE7Am+phnOsr2HoAUg5F+cC2+zN2FrYWwYl/CIoY1Y6h61nNoBm6/SQtvGiVNJWJbCdX8oNKzXYREQVh5mDh9Yw7ApmR/5AD691dA1Be/rHeRVL73lLbGtHx5eW2vQ0a9rNy8B5rOE/Kg12HR18OyfI2YmHWk3Mi0ZfMpxR+4Neo783z06kiGKYZdWrQzAg0bkit8xf1Au2baYmc4+aUOYrZmrmrhCTYMwMu5m0KX9HN8KUgI7oRwKugw+HazT3CnHzjukbTKJB7YsRUH4hAaUDNoIMmMEVRFW38Xza+RdJDpAEbij739LQZmIRgyJ3tpzPO5/9lKHRp5xwyPa4GozLUpm51CnT9nd5bk5vZ6ctlkzLPSEcXBdd/mOE3hmqcAcWE260YukUtYsJ/K/8a;24:2q+Bj5o+zN81WTJCfJgbX5MazPW0CNIzon7nWJ8E5Wra1BC5hK76udx3UfHZc3L8P5E+X8GWUu3SHXqn1hmyFwyLrbADPJhzVXzlP5eRT5A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;7:S0LrbzlZGwSOylrkQaYxBD7SQJIVj8vZIYgPFpS6VR9BiwQlm1m+ad1eFeO5AkG8SlBC4kuFSTGmIEkBI2LTfAxdoxXwgkjZKfmm0mXwI59e+Iwbz8oXbKiojDxk73osVcHUHRZfP38JNB1vgG1bAIjKrBYGID1DcwLWnc/tQKK5tIDJ41BcU0IMqXnXgbTTQ35KvSowdhjpRtB5ssF4oVIE+kuptbxe6L/+jL9Egw+CAh2r9YXO0dAzgwMlflHDF78yBbetIo9JezGMin5f5NuWUFwY1udOMgiwS/rnIdgnJ8O45uuc8qn2OkrnKqoAd2YzClVAZwVC5bumJdVrmQ==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2017 22:35:49.1241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3501
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58482
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

When building for the eBPF target archecture. Inline asm cannot be
used as MIPS instructions are fundamentally incompatible with eBPF
bytecode.  The preprocessor symbol __EMITTING_BPF__ is used to gate
the inclusion of inline asm in constructs used the by the BPF
programs.

Also make the Makefile symbol LINUXINCLUDE contain the
asm/mach-MACHINE directory so that the BPF compilation process can
pull in the necessary include files.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/Makefile                | 1 +
 arch/mips/cavium-octeon/Platform  | 3 +++
 arch/mips/include/asm/checksum.h  | 2 +-
 arch/mips/include/uapi/asm/swab.h | 2 +-
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 02a1787c888c..ca968415597f 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -247,6 +247,7 @@ entry-y				= 0x$(shell $(NM) vmlinux 2>/dev/null \
 					| grep "\bkernel_entry\b" | cut -f1 -d \ )
 
 cflags-y			+= -I$(srctree)/arch/mips/include/asm/mach-generic
+LINUXINCLUDE			+= -I$(srctree)/arch/mips/include/asm/mach-generic
 drivers-$(CONFIG_PCI)		+= arch/mips/pci/
 
 #
diff --git a/arch/mips/cavium-octeon/Platform b/arch/mips/cavium-octeon/Platform
index 45be853700e6..9ef3e4074099 100644
--- a/arch/mips/cavium-octeon/Platform
+++ b/arch/mips/cavium-octeon/Platform
@@ -4,4 +4,7 @@
 platform-$(CONFIG_CAVIUM_OCTEON_SOC)	+= cavium-octeon/
 cflags-$(CONFIG_CAVIUM_OCTEON_SOC)	+=				\
 		-I$(srctree)/arch/mips/include/asm/mach-cavium-octeon
+ifdef CONFIG_CAVIUM_OCTEON_SOC
+LINUXINCLUDE	+= -I$(srctree)/arch/mips/include/asm/mach-cavium-octeon
+endif
 load-$(CONFIG_CAVIUM_OCTEON_SOC)	+= 0xffffffff81100000
diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
index 77cad232a1c6..f8fff2ced216 100644
--- a/arch/mips/include/asm/checksum.h
+++ b/arch/mips/include/asm/checksum.h
@@ -12,7 +12,7 @@
 #ifndef _ASM_CHECKSUM_H
 #define _ASM_CHECKSUM_H
 
-#ifdef CONFIG_GENERIC_CSUM
+#if defined(CONFIG_GENERIC_CSUM) || defined(__EMITTING_BPF__)
 #include <asm-generic/checksum.h>
 #else
 
diff --git a/arch/mips/include/uapi/asm/swab.h b/arch/mips/include/uapi/asm/swab.h
index 23cd9b118c9e..42ed70015c70 100644
--- a/arch/mips/include/uapi/asm/swab.h
+++ b/arch/mips/include/uapi/asm/swab.h
@@ -13,7 +13,7 @@
 
 #define __SWAB_64_THRU_32__
 
-#if !defined(__mips16) &&					\
+#if !defined(__mips16) && !defined(__EMITTING_BPF__) &&			\
 	((defined(__mips_isa_rev) && (__mips_isa_rev >= 2)) ||	\
 	 defined(_MIPS_ARCH_LOONGSON3A))
 
-- 
2.11.0
