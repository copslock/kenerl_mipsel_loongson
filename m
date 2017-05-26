Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 May 2017 02:38:44 +0200 (CEST)
Received: from mail-sn1nam01on0088.outbound.protection.outlook.com ([104.47.32.88]:46656
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994796AbdEZAihvBdbJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 26 May 2017 02:38:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ZlsdBuiUTb+XMP6gVD+JkxMi7HEQJgfQIwb/zxgyFBY=;
 b=jN53CmSYYpdfxd0Psn+y6mhER8HKexgrDz6PUkBMW3qv3/y6L4clOBdFjhygN7YxeAOc9u90dPGsaQmhrbkbEK5kaNmCP7IoMWy6G+VnTYc/SV2RjGPxLXfkko81hg0Ea3qIoQws3ZPvboRd5LWhdcE+ku/CoW/od5Dxz6yWGMo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cavium.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM5PR07MB3500.namprd07.prod.outlook.com (10.164.153.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1101.14; Fri, 26 May 2017 00:38:30 +0000
From:   David Daney <david.daney@cavium.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 0/5] MIPS: Implement eBPF JIT.
Date:   Thu, 25 May 2017 17:38:21 -0700
Message-Id: <20170526003826.10834-1-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0034.namprd07.prod.outlook.com (10.162.96.44) To
 DM5PR07MB3500.namprd07.prod.outlook.com (10.164.153.31)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR07MB3500:
X-MS-Office365-Filtering-Correlation-Id: 5205b5c9-3e88-4d26-139c-08d4a3cf8854
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:DM5PR07MB3500;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;3:F75wtGA030cAYlEkUYHcm+sMECO03CcAhwYlhI41mQEMJ14XIrrLD6rDBpjleYkv2B13gqYHnZuVRHXerpmFh4GeIN2qiNPVSTqn/AXi1QbmNi3RMegY5ZG0r6FBq903IG+L6wy3aIv9f5wQcuxjUPmlVv9aCHIu1TrtkvQX/w22tPTT8e2r+iynLJQCxhoKpq+svEllIzsclJ74q7s/Or/FNYVUrlO+JkVI+YwT4DJtAwNnBHbpwTy9++JNcttpOwYsaF4EkYG60rEsLuknNGWL3gR48kKWLVfwIcaFjMjFHh1I8Xj1HrthbMlHW/sygyE+X2OPcWEU+ydzhvq+Pg==;25:Y8kwYtlrdKa6lQmJYwpEKRJxWT6fZSVgiaOqTjSsdxmGMrwcSmVBoH1ooPm/gSV4sGUNeGYAfbeKvZCCqdIHkb0RB8yqUeoJ93K5VFGX6ziYMR4uDA8bU6lR/yS3o/4kGeFHfeCzxFFBoHsugWOb7qbXzRZ2evvm6DhP8QY9FGR9q3Y02Vj+qYcazfMmrn18L9pgkiGGQ09vt/elvAdsYmlCAELP3jdkwi3+i8w1Q2znqeY1xJlpRKT0NP+oFKRrP2tis+rcUtywTh/3VZ2JgnY2zUvFw3Fvs08crhtjC8EZWBcuJ6tBbjarbuWV/hIvP5fJEqwHPEFWTpiiHhEMk/WLocBfgrcPcdmLgR0IEfcCVWxFvvNlZSKtz7JNOqdscfXHLaHMCWWBwfQxdkPGNpiltkvWFBsA9ya+Pimbv/IzTD8+lyQVRgp/PzVWcRZDwpiq6LtEbznnsqZBmipi8F4mEz4qydanEcBQf8tYGNg=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;31:5TZ/tAENHIbHqLznlR+g6AmD0Qw7i40xZvR40hbVzRgDBPocPQ0Y6Glo4qETc5e37cbJiuQjv0q8KuIO8Tt6OHXq+PY5srhsUwEs9c02R+11TcqUKWFg4HXz8M/7BvvljAVqObkJtL6UOa2kYcXqdAseR5H9v0pY5yhlc+GC8Gfx0cdj+GTXZVHZSHdY9whaDq2MTxnLN5+t3WGV3nhtIwndp67+mjLNMxH8dtR4Y6Q=;20:AnEfgdtCHJx1fEiQePj465vrPdULx6WS3gyIIkgERc1/fvZ+gZ+728fewvaQXuXQSgmnqeWjhlMyz6Q1GXoG565YUG3cXV4vQ3K4THe2HqZAVHyIlGYXwa3+cwB2w2+sRvR7pjNnSOYcZvbPcqF7eLRSO6VcDriwWZ2kUnxW0viSRFIXJt/9GuhiV4zp3nPEuaG1Kcdd4WD+/9CExqszee6VW3TltwQ0Ys2bUa6FowMmzn1UDR5XApjS9bstu6ND9L5duRqT5/YhZWr7eASb6mIfXkdW1p/7FuIG7kiK3FaG7kIrfIJbZP0sLmu2/JWXEBvTPl/RAWPhXlj62OG6wd7ujdCyMDERP2zOSViDtcnILQWcRolW4A452z4eRe6nfsBFn5HlUXU16EOTHWEMC6bYt6R03TVr+oQpf+vvQxc/mt9mKIdRlgqJ6Y5SkrkTG8x5I0Pz5/sAkWC+PoLhOm+h0TFETwk2DKg6UvJ/NPzchr4EMtVCmOXwMJ3lrEDC
X-Microsoft-Antispam-PRVS: <DM5PR07MB350016393A25C77851E187C797FC0@DM5PR07MB3500.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123555025)(20161123558100)(20161123560025)(20161123562025)(6072148);SRVR:DM5PR07MB3500;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3500;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;4:MAvQhktWsWZylbOwe5N/efiDFHVypKlJN2448ifnJWDjwzVP73WDNV1yMv39BmyJ3OJtbC0R0HWiWejSvjHQ3PNydL7ektaUiEIZJvieoI4qmwWFep7q5TvIFtD6N39kNeMiGiA0NcVdgt18lsmp6JV6518uGvMUV6oRYeRdLsC0Y+rI3FlCeR4AwyvSoAXtbtnebNG6v8/lkdxspOMbMBS9yKFJbid5nnvcldLJbT6hkAzniHYx3qnpIyR6qaPRAVzWzhlPnuP9juE2Op3Fq04O3YdFGySF8uSW2BksHa5lWSeU1zZH3eEEzbefh9jNGWJmrQUaZXuWLEokpN/DEKJh1R8IMUFk6TakG090BHSNmdG4PXYtkAFNAZKdXPEdJroUVnjAOcq3LwbaKejPswP1qeQx+UrE6DRbVkBoSXD6Ps+QOBhtoz10BCAZK+NeMw96i37obFIcySKCPWr4tOK/CerwDeF6DEd/c/rJVTxLahcEbQhuRw1gYMFTtAgtLu06fi51bgpnhlExf1kxalnl1/9/X4LYkpLd5jdyevv+CdvR/6NC6lhuOkaQEIPmJz3d6aYQ2bBXJwaPWSn9kBGv/jkO6EeziXyVchIobngTVFZSgUC4YWlG21vvEj8IOHbLskZw5i1p2H72hcaSDrjM1YBXU7GZiMuaLnoV29BFmIwoImDDcQRP2sWk6g0Y+WAKuY4leIhKYVxAXyacARFDeO8CHHzbskXj8gh/ehhRrow/IVASiLIEBK3BLZgaAYGuThCz7rjyuf4vxCK+I49glBniKMjBeK3RmLsRiPE=
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39450400003)(39400400002)(39840400002)(39410400002)(39850400002)(305945005)(3846002)(5660300001)(7736002)(2906002)(53936002)(6512007)(25786009)(189998001)(478600001)(1076002)(107886003)(38730400002)(72206003)(81166006)(5003940100001)(6666003)(66066001)(47776003)(50466002)(8676002)(50226002)(42186005)(53416004)(50986999)(6506006)(86362001)(33646002)(4326008)(36756003)(6486002)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3500;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3500;23:S/fKw1GttWoeB+m9fs62wZFC6swwZV6mRVRjU+3y7?=
 =?us-ascii?Q?3pWiHtXWWxEnB0FFFdfeKEblGAgX+jWe5qBStZSqctQnoY8Ru0LiAy7pJw/s?=
 =?us-ascii?Q?4CPhiO1xqLQcc8mqCajpcrPXebRTL7ojbLaaMgN6Bth+gfL/rkUEJ2uNi1ud?=
 =?us-ascii?Q?hV8o2goo1R6L6qbHt8tph0GRh5pkFyEP8PsFbdG/VOd9TtsshMz2bSXuMdyq?=
 =?us-ascii?Q?H/8k4X2aX/OVwXScGm9YXiSE5K+WJ3yBLHA3K/1tknAZyevuKe8lCxxWQfQk?=
 =?us-ascii?Q?RJKvAo9U8b/9ZC1/Ib7lFmhXMWwGqotb4Db4xe5zSPiVJxfw5CWm0F6d08bJ?=
 =?us-ascii?Q?SpsV48zlqkYR6cupH3c66ymOoFTJ4rvJ7K4+0kmH701JNYVdJZTXUnEAPRnE?=
 =?us-ascii?Q?vXwR65kC5CjzTmneUHfozTJXsoa+6gO9IvUbt88fi6JosywMKIq/9OwHJKzY?=
 =?us-ascii?Q?IIees+XevgIHRfmm1rfDVa4xF1WAVhzejKq08HxMIbN8WQzXfx3pkA/Delc3?=
 =?us-ascii?Q?n5cMIQr51CeB4ZF5f2361qUJt/ehxmUOjVIIhgnrK9Dn0sjMtFQQwypbSVYe?=
 =?us-ascii?Q?BfYhdPfJSzc7pDQ74wKV+EbwpcyXXB7MEFT4Mt8885oxNTEyUqt4L141GpyC?=
 =?us-ascii?Q?33aarhordvFXIQNWk6r5VzMFfgU1yx3Io1WtEyEGGekcO7UaW77VsVbWRc33?=
 =?us-ascii?Q?n/4RwdoMH3Af+mUZgyg8myFQiZ+CZiMM+wCIHNxihX0XkDlxKriPwDaVjjuQ?=
 =?us-ascii?Q?lrxYUpuG0v91fLTgCVyuIZNjcGKYgXd+4rSyXtoXswPYImzPFiamhzyMVfU9?=
 =?us-ascii?Q?0t7JlweYnl2NusnRy3knhc0BpEPDv7riXfPprTfJt+pI3tRzX4VHxxdVDAGJ?=
 =?us-ascii?Q?5jsBU+QtrHXYWJsm6pjgtdg6kvZGcDL1OLCtu3bmz0HhkAy3z/27emh9wW0h?=
 =?us-ascii?Q?xq2HqxbijC2gExazIyHdGTsuwTZMtVEmN/gzrHbrIs5iIzwkNvIFdHRPareG?=
 =?us-ascii?Q?kukdu47b+1daJEm0IcRAtTI?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;6:WTZV7SDMKBPpnPZcmBfxF+1BQhPqUNKQfoleQ3A8g6jcEXzDmHhTob/tmK9s7Wch4u5GBk4X2HHSOBmSao4kz67kuSLzJ7ke9TgvFFaB5mlAbYJJH86Md5Yle+5elArPoAsTsJ/Si95e85+3tY7k6uSc0gqVAibfRhzXxtYvm0iPx1gwy8EJHJrIrExYm1lnMaQmsdg/kZi6DSBJB0mSxjR6lKu6pKTFBrDIjiZXUjwTG5cf+lRKj6dxJeIktgRyYdBezqUauHQxllde8driIYEu+RyIicGpXpM8XAzxzc/SIc+ROhteMYRkuKqlpdQpaqm7VpHkRt+4MYa9nSJaFafFpFleMZCi6wzR6jPI58yXOJKhsfA0EBi0mqVR0V7RTm7nDjfcNNKkTh0j9GNu0+F/GIt2wLEVjbyZXe5L6zlNXOYOsmOaVK0A2cETsmbPaQBmMUpPD6QaPNBSmOTpb/0+rWrRy/J7CNbJmyz3LawwwhzKsy/vfnDPev6Sltf4pqenDIAIxtoZRqHHBe/ZDA==;5:NIuumZixRYWnm2xUXcb9NY7eiwZ08VSY0JXU39n2dJHT7a7wiy3kyNdoWRIHq2ah6ojgET6TpsX30MT2QkKwkMSS8arSpEqcrQ9EvNCpK/wdvfkPSi9XLwDRd9OG8+zej0HTbHCl1oED1iMQC0pH2WSjhWkfIaE+AKTT3R3PgfM=;24:UAKm51ozXlLvHburLOT6AhOVDX+y1flDj18FuIQnwGzBZ0A8ePNRpNZwJY3rGFqcuzf7bh/CE4VXLyTe3tirXiBuUkB7tFcYg+XRgWKj99g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;7:5V+chFHCQX6KrB8B2udyRh2hupsRMlvzKF+WGfrWekFwcyWVup6L19q3yfRz7ixCCFl00d4KN/wVBTAEsW4i3riGd1/7G2vaAPUoi5da9i8TFc2HHwX8Lr8AVn3/gNNIuTPcDGrNA1TYqdSXM/of8slSJYBMmO/0DR9o4PSo48qSa+nkaLz+FvH63tX5yUNKEyFTqp6h8zvEbY7lTkcNAdsbthv4L6f5nXlQvnT0aMLzu3LdoHrhH6A4zPYelgwlPFXf9BD1Zt4/HnuSedfmzCtfw2zA5CpIQiYlgpYCo7nz2v0HsnUrSsXZb5RUo9lPz2lXR3sJoh5rweO93SPaEA==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2017 00:38:30.0307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3500
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58008
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

The first four patches improve MIPS uasm in preparation for use by the
JIT.  The final patch is the eBPF JIT implementation.

I am CCing netdev@ and the BPF maintainers for their comments, but
would expect Ralf to merge via the MIPS tree if and when it all looks
good.

David Daney (5):
  MIPS: Optimize uasm insn lookup.
  MIPS: Correctly define DBSHFL type instruction opcodes.
  MIPS: Add some instructions to uasm.
  MIPS: Sort uasm enum opcode elements.
  MIPS: Add support for eBPF JIT.

 arch/mips/Kconfig                 |    1 +
 arch/mips/include/asm/uasm.h      |   28 +
 arch/mips/include/uapi/asm/inst.h |    9 +-
 arch/mips/mm/uasm-micromips.c     |  188 +++--
 arch/mips/mm/uasm-mips.c          |  236 +++---
 arch/mips/mm/uasm.c               |   59 +-
 arch/mips/net/bpf_jit.c           | 1627 ++++++++++++++++++++++++++++++++++++-
 arch/mips/net/bpf_jit.h           |    7 +
 8 files changed, 1930 insertions(+), 225 deletions(-)

-- 
2.9.4
