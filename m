Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jun 2017 01:50:45 +0200 (CEST)
Received: from mail-dm3nam03on0048.outbound.protection.outlook.com ([104.47.41.48]:38921
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994627AbdFMXtwwB2HW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Jun 2017 01:49:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=V4dlkCL9Eww4f6YE06Llw1phKLnJdFZC9FLZLy2yZuA=;
 b=A17L+z9ChL7Jju+08CgcEAU3sOaJY8vSleK0DLnxxBhoUuabeHjjiaNHsmUQMbwFj+tO0I9TyYOMLIWGMkek1FvPhLSh1Q3PW5KlbGxvtUhl1LjAKqYU2gtAwiwevUqUv96EfBrXSadg1FJAbZeKBA28II1eG+dAYT7bCEQx68k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3501.namprd07.prod.outlook.com (10.164.192.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1157.12; Tue, 13 Jun 2017 23:49:45 +0000
From:   David Daney <david.daney@cavium.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 2/4] test_bpf: Add test to make conditional jump cross a large number of insns.
Date:   Tue, 13 Jun 2017 16:49:36 -0700
Message-Id: <20170613234938.4823-3-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20170613234938.4823-1-david.daney@cavium.com>
References: <20170613234938.4823-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BY2PR07CA0024.namprd07.prod.outlook.com (10.166.107.19) To
 MWHPR07MB3501.namprd07.prod.outlook.com (10.164.192.28)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR07MB3501:
X-MS-Office365-Filtering-Correlation-Id: c2f60fcd-bb9f-43bb-9b3c-08d4b2b6de81
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:MWHPR07MB3501;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;3:4TXUqgwDoHO8ZQNqxXx/L4osKv+1KQA8gwh0Mt+lQIv+d8uklEF8zz8+ewJQKHOaIEtDIFmE2iDNLLpIvGGvOcGHE/SLOMM/QAwPpUQho3EeBsPC96x4L3Y8oF26oMF99DvKcgJjfuQsv+idr/Noe3C5UcgAPtHDlTss/fSbPFvRt5elFRdrQgD7tZQVkwYWmaBbdrxpPwJJgtJVOP9JXfaXZerTKCpJ4ePXobeioqGpzWURsNbFUnWizIzWai/zyWs6t4I8PQS868a/8ZlyBVtV5RXSSPjKzgqTg90BRnNU7OfPro4jgW+u99TkwqA+OsrQD/lOM4xYCKglJDeqCQ==;25:Dw/O34RSg8wiJZNA2Htb2Ntitguy1hTXG705ya0UeljwcPmTdgc2Cz/RpgyWOXBDnKLm1ct/heoVJtjwfSNORJsOD42R1dvmOlD1fyKbcDXElmPtbCN1EUBSntV8JDpOWsl3BSjoWGwfB1GHFqSwkx8yk9j89izvjzGoFGD3gmCFQZdToCHwcMPzAN8zdmCr1WZkGOWQxKmOHEPMXOTgQMVeJ9pa58xyaiABakELHc1MWIxTvEPQhdh7F7A7KoH+WjhsqV+8Tq86c3waG0v2rrp9wLJlEFinZlxC7O0LawRuRsjQ/8HuQNZpDgglzCeqfCe+eMNBvTLE2ZW92vRzi6DwItPHyfxKIguVCvr2M3qHACkCMPSTjUmpw79A1GUaozyYuAVrwj6H1Epa/Q4TomFT43xgCtOpfi1gQEAITLN/Ngb0xgKu23xHXG0csY8Om8dmWPELNkQ+74FhaaIB86C5ks9d2QnJMUIoLQ/yNac=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;31:Gvy3ljYQR3mvRlq4I211Ty9ltkXQ38y5JUuNVCg7qKkhIAK78+qYaMEnYzSClSoUHhNxka9LNXQ6Li+Djj+L3IG650gY+DGbLg3w2HoAb8GdNy5AGxMd8kBRsJO75JMZaqWedWwMXgLNPA0JIJdjG1/H/Jn5M8A628Pb8FxOI/a5jfs+v1/SMb6M4+NoH0LEj+kDkrKYp9z7nwzkrhPfTQsE3kEcAaV4DgoLXSRromU=;20:V/LU5aYtW4c+jGdprGI25vsbyiLteO9M/Z+1ZS0yjGGyGL2YZZdfLiBlcgsG8rmBxjjxumLMfv60ERqFGKLP4rqGUFSTiZvihlRyJV3PEqrgDLcQYDq5VUy0yJRWmJFe0ScgLtPhDg4pMyazYi34eura5XdQyaqHq3HqIBde/FxiNjpmfus1J+Oyih/iGdqGPu4EoRKaTosnr4JvhH6Gv8klYxs6y4gC5ZJRgUsYMwwOI+xpXYt1mAuqsb1tzwPpdikCEZrEj2FUUS3nFYDEAr1b8bHQiJLT3Zls1CqJT2KeukYWCoOX1Yp6Ci5f+w0JvI1o6nl1u1ZwFoYT3L1y/W7xR/w0ritYzHmgSQiqUMymhoPPndv76oPnHFL11MbPwFtebenwDKCrs7lpHQY66xZOJITApulitSMikCvYx5fkEW+se69SUH8xdLqter0ii6OaWsGSxN9EEoPyFTqECI4c8TAL41c7Nu8+dlD5aK123op1eqdq8TM6NUyIz1Cx
X-Microsoft-Antispam-PRVS: <MWHPR07MB350143B2A4D569F16CD82E3B97C20@MWHPR07MB3501.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(100000703101)(100105400095)(3002001)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123562025)(20161123555025)(20161123558100)(20161123560025)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR07MB3501;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR07MB3501;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3501;4:sdon57zVFhmDY4ffwUSqdcYkL/Yfx30MmKx2SjeXbI?=
 =?us-ascii?Q?H8NQeIEESShW8tv3aLU55g8JS2aEyzwp3dTvxiy/VDtUE1M2gGj+IbaUOwKu?=
 =?us-ascii?Q?cEi1iwjhVVHieK3QCO1uZ11hs+ss0pJUB/7PN63L6lgX5NxZ6Db+PnbdnBCE?=
 =?us-ascii?Q?MuoKQdboCQgtgUcBScjcwf7EY7h+LuQDF1/b7oNT0ZKytSPP37sMK/FagLdo?=
 =?us-ascii?Q?bmLA9QDv5MtMqS2UGcE0UbYoAPPIo6X2Nx2TOye2AvZRksSFbXVjb9SsYTES?=
 =?us-ascii?Q?A0bcNmdnCkSEfUWGjI++GHjUCsNv3pbg1LHcCUBpQMXFGzQVjrfr7FP2M5P6?=
 =?us-ascii?Q?qFIoRyhGsQj9uGhZtZExlxYwWTq7llMVxNefou2cOjdRPhw9Tp1eh+CL2GKI?=
 =?us-ascii?Q?Hk3Zio5PBULkYEtIE4e7mHfxB9dActfCmFYzkQNDJaPQ1JO7rWhdL9f8UAxt?=
 =?us-ascii?Q?eTdNdttsh/fOXOKegyMhB2mpCiO8Dt6tE6nl1YK72Z0nbtB9eV1sOiPTNqM6?=
 =?us-ascii?Q?ZRumPvE/0V0CvMt6JY4wIhGWrGMJOasnhQzgNH5JrckSfruWY//QeasQdq/h?=
 =?us-ascii?Q?0GdYLjXTtXA8VKVnbH6sa6crNgJR8a3LjeKVuDkRirKeORYb0qZhlbN5FaCz?=
 =?us-ascii?Q?eCwbbat/oRG/6RPT2uXNBcQckMZ9vKrlAApS7nYDTyo9Bp0x7kILryXx9hSb?=
 =?us-ascii?Q?mVlOSkIUDMhLoYAIU8l01YjFWOtT8ANKk/9FmQCc2v6tfj2cyzwei4nMs4Z5?=
 =?us-ascii?Q?K0kRy8KgWLosRLjSTDk2FWF/sXjKVzF40/I7FU+1QN7DXqXJ2veINdNi2ItE?=
 =?us-ascii?Q?U9aTb4HgfF/16sckGRVS5lTEzPqmKLAy2m7gMvWiuN5WeD6O+JfsTIYnchas?=
 =?us-ascii?Q?TvxlonRdxZl2zWvlEyokB57zOCIkG0LUTnjeHWH7p8BxZ9QOx7if8jXEnJfX?=
 =?us-ascii?Q?NFlCzzWUAUvLFH9qab8BuqC+bwv93zxZG4L+X6aP9vkEAxtuL3wnBVcpfFSS?=
 =?us-ascii?Q?ddRGuz6nYEe1l4BFOqdiQKVp0FhK6BQSomTOJZjivf6lIIkJS1D2oBCexZyA?=
 =?us-ascii?Q?VU9C+2s8kdiID4pjECO6uJr+4bzKAIWr8t4wlxdS4UWrz2j19YHWgxCPw3aa?=
 =?us-ascii?Q?YyojI+mouL9KXQHktwwQuVQRw6X8/L?=
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39840400002)(39450400003)(39410400002)(39400400002)(39850400002)(189002)(199003)(6512007)(105586002)(53936002)(50226002)(53416004)(2950100002)(106356001)(4326008)(189998001)(6506006)(25786009)(42186005)(6666003)(33646002)(50466002)(69596002)(5003940100001)(6486002)(48376002)(76176999)(47776003)(7736002)(305945005)(1076002)(478600001)(101416001)(2906002)(81156014)(8676002)(81166006)(72206003)(107886003)(36756003)(5660300001)(66066001)(38730400002)(3846002)(68736007)(97736004)(6116002)(86362001)(50986999);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3501;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3501;23:OjPBNjiP/464mkaGj4g7sevimu92mRKGhXdOKBHZh?=
 =?us-ascii?Q?lzrXvLU5AK8VdujTnpoyJMZ+hkCfknxOzJNFIYc+D7hd9fuZ7ZACx3LyAGw5?=
 =?us-ascii?Q?gBasCFKyKafX3WIG0JcNblh9CGPiiACmhd51d3tSnlpOd7yt5A27KkSMoQVZ?=
 =?us-ascii?Q?mEtgaFii8LCanN0s2AxZwzStsh5tRRrsuXpDCvhbrI9i0bAAo4TCOgC6i7mV?=
 =?us-ascii?Q?0M3PTIlTIZrIwN+NAH+A5Jy7UhloBDMZDsX9vCwraW80xbG0WhCw80QkSErK?=
 =?us-ascii?Q?PCjbYwB9PHXgtUT6ZuY2BNqHatQpZKxHOrgvWab4qpNptaP8d4Vqs0Bg4E3Q?=
 =?us-ascii?Q?pOxOjVDaCR3QhiES9k5ZO/DD/kynKjNenCWOeLmQ2H9VRz9NlZ44ktsUm2Ct?=
 =?us-ascii?Q?uNNbKHkhW4hp63ykXwpzr0fItUTLVCus+RZ4XOXDcRpgMIvSyD0BNs+Sz46p?=
 =?us-ascii?Q?jMW8F3tblsfFopDRg8PC00P87O+MG7fpzHeOzA5kOYp5PpheFY4DgUmUxOvV?=
 =?us-ascii?Q?kQc5YVdoSPus21XDgWZa7XdIKXdgIgXNaBJdwereYwM3X/wHPhyJRKkhgO9T?=
 =?us-ascii?Q?i9OAaPvyRm8eU/kWJkKXjODuKTa6zlxy6oxjMVcYu+q/U55IbyYPoxMPBq5r?=
 =?us-ascii?Q?9589O2SQUTC9ZjA8j43TDDIQ3QCu0K497bqrl7orKhVdBu5Ymzpbbu0evTFR?=
 =?us-ascii?Q?4HaDdON1KQFz7buLiZgRDTGAsjrmAlpIBnPL4sFbi08lMFjo20MZ76VGRdAZ?=
 =?us-ascii?Q?Ik5SAADzh3SW8jsmKr1ESIyMmGNTR/qWYXvlRrs3P84P1DDSr424jGZpXExj?=
 =?us-ascii?Q?IRcIQ0Cn0u5oPv5dDeRW+Zi29qJ2kBR04zrR77fPDqbA5/2y9pwJnxOL+ejs?=
 =?us-ascii?Q?G+VkoKKVCNbN6d9ydeCz30Wz96T6acWxB+QQvQ/Wz4tZ/qmbZA9peG+JHQ9e?=
 =?us-ascii?Q?tAxDdI2z075kvlGheb8lcDVc+zZ2c2zAFWQteLiE1q+wCwHIE3Kb7yu+b546?=
 =?us-ascii?Q?99vyji+rwNkZZyHFN3EBePpw6tO830At1dlkuaAk+4rPza7xVnCmA+OzYDxV?=
 =?us-ascii?Q?QDlOBUpAQ/Qar2UVXo5U1VqNsUG5hycXWmCyfUm3/Jjm1fuMxYnLxNRsKr5L?=
 =?us-ascii?Q?NZc/gH32Jw+BtpwsPpCH4Nn1WIoTqFm48gt2k9fkbOlQMSawhyPxvI/tJdM4?=
 =?us-ascii?Q?+tQ6AAEaODZsMoVUOuJZZx5B4G4s22Xz0jFGsrSftO0QSG1bbZdk/Foo1FPZ?=
 =?us-ascii?Q?el0J/Yz/+5gfre6N8M=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;6:DIbIoGnkwXCOqX8J1Gc4zQuirvmapItv5SrRm0rObuXYmhnzwkmsAa9SdzjzA0uPUrCY06DUT+rIK9/t0vzgTWT8/etTeVIPUe4ONezUyCfc78G1kKVXUNcH95X79uFoAiRzcEqMSgDKKJw6Dk+8KSS7BmqJFxkDnw77DQMhgTu2/Z7q9hW0uc+tn7q5Ta77xsX8YPug9FQiGROFF4JYMrvh2cE1B9ZccWAKZQ9PFeRpTWMv6PAASfNGKI+xK2wULThwX0uEZJ/oReuzYlef6OSuaujQn/OxGrjK+ZcqhReZDwdWn1KZYeBrpf+6rPQ0ElZuPabo3yNieS48YS5CIQKQIYtY/YliHh5uDziUTQ8UxM6eGpCee7gZZXsRqAg8xhCeFT6RWTJ5S67SUJhVo65BunJhozc5yuW+BTRjmNhBybLToJUp62R9mWXgZenXnkJZ8Jgeh5fNnTt2fL0CRmTfMEauizSsRsgeo0h/DW4vVdBFG/qdYum1EmmXpTLOTzqNccrsmC9aurBg8sjtJQ==
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;5:lP0Dvq1f2fPGqR2j4nDd6KXShQnb8sgo6NxN6ZB+UfNal0VnWyDvOcZB9KsKgi4snK6Pa+uxEC92HXpXlo68MpSKgVhZblsCxjg3drSRCUFHzff7MsUWUSHGTtJQM0pWvElTa0zF82ebYK+Fu2qzPzp0JFIFRbPzclIp1US3Nr1VLSfURmKCJJHiQGSTDnEzqm4ccKviuqTcKf5f/L+C7rSDOaUp8vhFTugpzb4GjBt+DGwVuLrzR7gIqhd46AM7THK+PvUWIzrTWldXHof12QjVAsXnH567iHqybIStrmJLMiOam1Np3hgMSqFzGErjc/UuWMuUGNBsDziy88p9q9xaYNwKD7t+OSJKmPg0f4hRJCql9rK160W5cbX0ur7ySepdUauPTHLBfp2Fcv2SO9ulR2N5s66/LVd1Ah1XOPiuAKc2T3Tb8RA7JntfqZcwYbzLsaebWmMED8WtRPJIG1a5wE9Ti81Y7ZPDivrAvGMsf3jrL1aIhQVbvHJl729A;24:zgDv82cLUtTR/9Nw/wj176YOjGYQYSkIOV6lkFUsC33qe2VwO3PnQVoVfZWWKTQFnSrrHge5h/KCjNC42yNngWqi3C31BySjYVn407NMDQ8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;7:VuxI//SHaU3WB75yCxarh/fjBRUM0tXmDhvZOKMXYojra/IB4QPJLHA9LlXBwtlZA/60KZte+wndkiNZs3H1W0pMd+EUdlGQ2yDKCy3UgPZqIAjvVsXrU7PYUNM5yeC85lXaEpHafdMu5Frz6W578oPYQPbJF70hfGJEsBrTQ7EkYDvs43DsJtRYkhGPm3i0EbgH35jqLeYAudM/Afw4442pnKxQz16hvpM75bbiPFWrpFo7xIckQzQIoh0y1X3QR6aPMY4X5ejukUT9IoGogEBxSGhNUeMBkYZfNVLzliarDm60bLVRded7unrJVY+P7N/g63GE9Os45e6jqrQSRQ==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2017 23:49:45.0410 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3501
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58434
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

On MIPS, conditional branches can only span 32k instructions.  To
exceed this limit in the JIT with the BPF maximum of 4k insns, we need
to choose eBPF insns that expand to more than 8 machine instructions.
Use BPF_LD_ABS as it is quite complex.  This forces the JIT to invert
the sense of the branch to branch around a long jump to the end.

This (somewhat) verifies that the branch inversion logic and target
address calculation of the long jumps are done correctly.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 lib/test_bpf.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index be88cba..9ecbf47 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -434,6 +434,30 @@ static int bpf_fill_ld_abs_vlan_push_pop(struct bpf_test *self)
 	return 0;
 }
 
+static int bpf_fill_jump_around_ld_abs(struct bpf_test *self)
+{
+	unsigned int len = BPF_MAXINSNS;
+	struct bpf_insn *insn;
+	int i = 0;
+
+	insn = kmalloc_array(len, sizeof(*insn), GFP_KERNEL);
+	if (!insn)
+		return -ENOMEM;
+
+	insn[i++] = BPF_MOV64_REG(R6, R1);
+	insn[i++] = BPF_LD_ABS(BPF_B, 0);
+	insn[i] = BPF_JMP_IMM(BPF_JEQ, R0, 10, len - i - 2);
+	i++;
+	while (i < len - 1)
+		insn[i++] = BPF_LD_ABS(BPF_B, 1);
+	insn[i] = BPF_EXIT_INSN();
+
+	self->u.ptr.insns = insn;
+	self->u.ptr.len = len;
+
+	return 0;
+}
+
 static int __bpf_fill_stxdw(struct bpf_test *self, int size)
 {
 	unsigned int len = BPF_MAXINSNS;
@@ -5022,6 +5046,14 @@ static struct bpf_test tests[] = {
 		{ { ETH_HLEN, 0xbef } },
 		.fill_helper = bpf_fill_ld_abs_vlan_push_pop,
 	},
+	{
+		"BPF_MAXINSNS: jump around ld_abs",
+		{ },
+		INTERNAL,
+		{ 10, 11 },
+		{ { 2, 10 } },
+		.fill_helper = bpf_fill_jump_around_ld_abs,
+	},
 	/*
 	 * LD_IND / LD_ABS on fragmented SKBs
 	 */
-- 
2.9.4
