Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2018 00:25:32 +0200 (CEST)
Received: from mail-eopbgr730108.outbound.protection.outlook.com ([40.107.73.108]:30880
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994673AbeHFWY6hdZ0G (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Aug 2018 00:24:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cx+kVq6yDT4LQBdhTk+FwBl44oCNEpbFi8deBvN8SOk=;
 b=KFxFFw75eCxtlxZd4PdW3o5TwP8B3onNoI+I4WkIRRHLDXIWqXoTxGuEgJi3xlcZB0yV6a9V877kCvQ4/1ij1QNTQuJy+nJD2MmAcUZQB4F0ksDbkIZLpoHx0JKjds5i+5GrkbJ4tR7ufziKeJhLFpY7dVZ/busPBgQSXXftm1w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 BN7PR08MB4932.namprd08.prod.outlook.com (2603:10b6:408:28::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 22:24:49 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 3/3] MIPS: vdso: Allow clang's --target flag in VDSO cflags
Date:   Mon,  6 Aug 2018 15:24:27 -0700
Message-Id: <20180806222427.2834-4-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180806222427.2834-1-paul.burton@mips.com>
References: <20180806222427.2834-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR2001CA0045.namprd20.prod.outlook.com
 (2603:10b6:405:16::31) To BN7PR08MB4932.namprd08.prod.outlook.com
 (2603:10b6:408:28::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6494273b-cc0f-4b36-c47a-08d5fbeb6c57
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4932;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;3:SKcPuteM3GljpLAzovhFY56I4Ikx5Ul2MNR0zGhxGiXGCVr5J62UuT44L0ujWJQJ3lboZJtjqVGgJpPnYUbXfttLg5BUfcjdMb5w/Oqv9D5pUlteWeKx9U6bcCegeERtRB1d/0yve4/2K0JEDYWIui1KRJ2sO/gQO+ofp5BDe0n0cd4k3cngGE5L6J3wXAEppN+jDEKUw0bPxY+JGB3mn0ahh/EdCuSfQlBs3CjhIdx/zlmh9XPMEQnV1cZTbI8i;25:eQscXWYZIzCGA/ruoqXOAd+WUbIN6toTxBa66zwsF766PcKjWYS0TvODhHLVePP6EKoc6JHdJsNAIBZIIlmoK22ZDESUhMiwGBlthlT5D7oWqTO2Hfr4fE87i8thNxnv16SMD4DneSMXxwJOedwOzKNfihJBqZcyxOi8gMAsD+pZ7qfFlVADAwQ0dHcLAlb372Hkd2pyjt1V5e9Q/wgT6Jq5IypRZwtXTWhGL6RWhhcnTBt/UzaPtwicpq174K7up9jXImhhvbuJDd3tq57i+IgT3m2GSqiLVQruZtFzefB+nbu9hPsLZPwDjoolzc8REkWp9HMg6liC9n84H8VbHw==;31:hIJi/PylJK14pqGAKqOfImIaoUf8PzDImPzAqNa5BqJzvKwCgMLjXLBCoIjjWYe7dkZP5J5s3YMaMJUfT/rt8lQgFI+oQKDe5o5qjPWBIsMnRWtnpaCE/In3tZvt3YDvyTKPXEGoaePSdpJdp+3y2ZK5ND1m+gJwM9t7Thhl5dXWLI6AU47PTE9Lulg0s9nSU+q4x3S5EzIQ5Tr8K7+cA/7Wsa2a4B7CRdDZcqMx2KQ=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4932:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;20:3shc1P5xny6GM4zS/ivDRDet5DDLo1NpGFfv017gZ2E6biD2w/Iyzh9A6AbTf2jyaB89Bw2c6q8cE6TfjwfekOI9ygmEBgVudCoZ6wPDgxTp1pwUaUSK8lh7gjh30izcaQ9l/FJLVqytxcEBmmLsb0AUUDSQ8Y3gpcTpNhPZrdgwdEvPwNlAS+bVc7abN+BMQ6/HdV8TYGCst5PPJT0R7Ce4RYXq6eOZhFbwfH5sd2+YutzR25k5zUcX1AnyzoTY;4:U/8AUznJM01RGvpIwvaUWUi7ygA7xFcpoJYX8/YRXjIo3067/XWZgLbActn+1Bwc49u+8yGFft+oa1gO/Aqfln5JFT7Uk4FvKvimNBDAHbjrV/zDEdvvdTZt7HL88Tf7uJLjGOv7clsyhKTv1EMpYcr+GlpavvWFALFAgydXPO/z4BEu/YsfA+wDRzF1s61iTMiJ8h2VCUV3Zr72B5tCKda7AP3gl5x6uTFxGTUE0Gl0LEoWmAAp2vtBAenbyzf22WOCs6MCBIQD7dArslp80w==
X-Microsoft-Antispam-PRVS: <BN7PR08MB49326A90FB958ADBF43B2FE4C1200@BN7PR08MB4932.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN7PR08MB4932;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4932;
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(136003)(376002)(39840400004)(189003)(199004)(97736004)(47776003)(66066001)(42882007)(7736002)(476003)(446003)(11346002)(25786009)(3846002)(1076002)(81156014)(81166006)(4326008)(486006)(76176011)(956004)(2616005)(305945005)(8676002)(2361001)(478600001)(68736007)(50466002)(6116002)(48376002)(69596002)(5660300001)(6916009)(6666003)(2906002)(16526019)(36756003)(26005)(186003)(6506007)(2351001)(386003)(44832011)(6486002)(316002)(6512007)(16586007)(50226002)(106356001)(8936002)(105586002)(54906003)(53416004)(51416003)(52116002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4932;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4932;23:8ikX9JxxL0MMuGlSpQ9cwCX+/dZofHILDDdzujm+R?=
 =?us-ascii?Q?O6g7v77nNd9qQJqGx7qUPwOUA8OFfIl3fOyi2mfzHFK2lf4njwKAX28IYMcb?=
 =?us-ascii?Q?AxMCA33iTGALPxnwv86p6QO8i1WsvLv9XXk+Ebj4Qov1xgvUjqdAFZ3dglSW?=
 =?us-ascii?Q?2Ue+erbzPtgaUEL3o+i8hAg4C5za0cWtnCxvxByKdd0W3B2M/E4QEY2+JVEZ?=
 =?us-ascii?Q?ENKafkiub5lyM8K7YVqiyvJmdcRAqbPAczDSPqZ607OyrLm18S7Z+vZShNe2?=
 =?us-ascii?Q?/OwJNDBH6aYBmvxnBMqa8mb6lHYNn5Rw02d8mSkQ6Dxwbxrxs0jLQ97t3Jm5?=
 =?us-ascii?Q?AhuHVikvvolwpwZmmvQafmrJ1qZRYNFilJyIpM61kyn+wzCZg+PgBLZT60rK?=
 =?us-ascii?Q?lVWkYgQNObX1Ae4wUNe2tDjGQKs2u5Z+YH5kNtfmcrxYnwyjY9tXDizc6VAl?=
 =?us-ascii?Q?6GJqb80yLjCPBzU/k5TMd29CPHSL0v3gtsD5urgkh47I9PT6D0qG8F76E98w?=
 =?us-ascii?Q?IDFYzcY34QoisWGZWcvUREOC5u3bawIp4VobUKIeTywZD2Nfi9hDouWkjRrf?=
 =?us-ascii?Q?XMlqKq02myD2NKCZQEACqq/bpFkW6IkH0gAkPX+coZmRCMG7WVb/2H5lgp3y?=
 =?us-ascii?Q?XAlhGtEWudzHNPr5thg8yBmyyKgxB9eon7B7vZ/6ubPt9yQBmk96VHjTi3aL?=
 =?us-ascii?Q?jmD8iPV54g1rALyJWk2snxV/ZFrQyWG6flblQM9ml9WYyJXGfBNAIJp6okGu?=
 =?us-ascii?Q?lS3NQis6IoTSnT+q1n9N7vBNa2PZ7ah53vqY3QMKbu7XYbSoiGuNYnTrYAPD?=
 =?us-ascii?Q?apiT9GHgkv5ff/uxdkMH3gbXsWH/FUfUDeyNKU8dL1HQ/9F7A7iNPC3J6zIV?=
 =?us-ascii?Q?Qy0vwLg8kZdLlVQw5Xx63RccrqgVLqKN8irOmS+p4Fg5qKtYjxon4jsXlx73?=
 =?us-ascii?Q?Ej2sFMMuIPhukFUy4g84PfYEoIUwGSG1LIDEH58oa/fzvz0nSSBtedHrly/y?=
 =?us-ascii?Q?zb/gEN/8Yws3rSWV3AzivzAWf56aT4HV4AUe1Dq78q0KaXbFtwo7c29IQIWr?=
 =?us-ascii?Q?NAf+MxZempVeorrjtoJC1LLmRnmVC2le1lHuQ6OtJaoa+zbA4r+BOci8VD3I?=
 =?us-ascii?Q?v0gfDC0iHkM2G+4+An6bkY1XrPMK1bChZqgu00v1opU3iNRvUY4CG8uvxoqJ?=
 =?us-ascii?Q?vq9BelCDtpzSc9seh1/evh7XseqP+yhTzK6IJqp203av0uPQL5C+L5wlqMtt?=
 =?us-ascii?Q?9D0SWJTOQpgt97pbbfSTKqURVvBv9XlVpUiV9E0Jc/0Ekaj7/Zv8a9wy1V2F?=
 =?us-ascii?Q?IHShOE6+gf0v4kQqpdccTQ=3D?=
X-Microsoft-Antispam-Message-Info: PwYt0FlkeNX1mHZ0P30Z52JbVo7WtiifkIlgt6o12TlkxxiM7Pr+eFwU5XuOhQ2XXU1nnR2TrWQUnvYNrVjPeX6hI9b6FZDK3gQADcPi/AdQIkHhaHhG+ifpauAH28kfOeXX03u2by3SJtvIU8DJwCKDGZa7AOQ0lDqUwZMhNSaYMdnDfuMHKTUU74iltcOjdOUA6ym7opy/qM5xQcCY02nk72Rwn9rTBZmT19qXfWI2Avb8mUlIPQOHx7DI5MjPa6nB5m14DX2UogG3HfV9tqBncRH2RIh2gzfvw+65M1hsNuSuPWOkDYvZC87pZL6w9mv3dUfrLpV43d8zgxdM7pa6WlYR5Uxm/qMCFfh0gnU=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;6:/2mam0/al7ntefrPROFfvqJbg5PGAoyjzJYRBBqw7mbtbkJFSQltsbyQsQkoaO0cY5/FRVOeLxhLcgpmBkpVo8a2HWF0LYFTns+exNa5GKvJfm9Q5EmNbKCDucqVwsbB9XH5s04JA3I9rVIe7t0VS3O049hggHTvhsGb2sTvK6izhA2cL8s3/Q2/ExMFzIbfIa+7un0vnKi+R4oaERExRsmS1OYfWdddJxKf4HTYORyEW7JkbQJfvVsHJrwoypUWReeu1sHT/M5kL55rx22rX9dAzFJ0iIcwpnYKWznrZCydI8Kxrq6x5bFtRtlarYHeUNFos11rvxAdzKi52VyiTzMaKSLw5emUazAnMRsEAnW9Oh9T80durMd56AME5+kHMbqcAAxzC8a+E0oWZtzZmbDFN6f1rDGWLqCR1IfCG/kvxyNHZuRedyR5FVaAnINT7Po7QgliNbgQEXxn4BIuMQ==;5:HtOhZs2jby7CmTRyEnGQkTwLVpAoln6rX1HOHNoEPKqVrVegXEuWN5Pd/zwlWbWvxNe07l1i7ecsFWGt+mg8CEC6IiA9pA9C+a3paXLUldds3Ip/oZzIGJTJTXUWUao4IqoekLaG8I9so+dNTJNG888Geg5qnyzqRuS1t7jfJDw=;7:dRVlkomp+ts2YCXdVFAvjPdY19GWRNvKWIZmxZCisWMHdXnH3XxGflUzWYJvR5RKzpRc3geL2xn1/yFj7xm8RuuZ2l3KC7EuH/hOyKCFkICsAAWO8j8G3XDemf8g6TgbWfFLNh2DtO5XTr22rGN3QK5vuF0LQkBCktZMHP4Tb2OOGeYKFIdH/Qb/y5oUnabklPMi4MUL2PaOEKr7p/GyYLbqwYAXhMQr0fboRa+BBj9GlABjyYEmcO5ZsZ0Nt+qF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 22:24:49.1767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6494273b-cc0f-4b36-c47a-08d5fbeb6c57
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4932
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

The MIPS VDSO code filters out a subset of known-good flags from
KBUILD_CFLAGS to use when building VDSO libraries. When we build using
clang we need to allow the --target flag through, otherwise we'll
generally attempt to build the VDSO for the architecture of the build
machine rather than for MIPS.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

---

 arch/mips/vdso/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index ce196046ac3e..39f42af7fc7d 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -8,6 +8,11 @@ ccflags-vdso := \
 	$(filter -E%,$(KBUILD_CFLAGS)) \
 	$(filter -mmicromips,$(KBUILD_CFLAGS)) \
 	$(filter -march=%,$(KBUILD_CFLAGS))
+
+ifeq ($(cc-name),clang)
+ccflags-vdso += $(filter --target=%,$(KBUILD_CFLAGS))
+endif
+
 cflags-vdso := $(ccflags-vdso) \
 	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
 	-O2 -g -fPIC -fno-strict-aliasing -fno-common -fno-builtin -G 0 \
-- 
2.18.0
