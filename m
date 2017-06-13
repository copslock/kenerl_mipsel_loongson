Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jun 2017 01:51:30 +0200 (CEST)
Received: from mail-dm3nam03on0048.outbound.protection.outlook.com ([104.47.41.48]:38921
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994628AbdFMXt4OWfPW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Jun 2017 01:49:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FwHJePCcUy4pB0/kEdIQQNbz54MvCQPnfn0JeyUZcic=;
 b=MxGNira0vxcUwYi2uT62tAq/SlxTfN/gJxbB85wvbYWsHsfgdNTiaVTRY/Dtxw1mx4RRENKOL/e8W7422dp10ruGKQX1JJZ2pvYhDBz7CZMlGdyP2hULF14PAWYpfnl6Vbm7Jh3QX7yapM20VbDRjFIBP2Sa7U5V8LtTaYfGeg8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3501.namprd07.prod.outlook.com (10.164.192.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1157.12; Tue, 13 Jun 2017 23:49:46 +0000
From:   David Daney <david.daney@cavium.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 4/4] samples/bpf: Fix tracex5 to work with MIPS syscalls.
Date:   Tue, 13 Jun 2017 16:49:38 -0700
Message-Id: <20170613234938.4823-5-david.daney@cavium.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7c0acaea-9bd3-4286-f5a1-08d4b2b6df3d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:MWHPR07MB3501;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;3:FB+CDRGOoBoZ0+9LSTFuDn1tXo0mNBjz2MVXJGIk2AAn9JJ5VazzhFOL8iafjcAdwa1AqqLCCuOJJ4ZPBj7Zyosb6yraTMaWFiSIKWbXXpM7mnK4NyqN3Ll05Xwyl85nEUQI4XvdgqHj7GasvHbXt6iBAGvqZr++BhVWeu0qZNhbEs3IstdzxkeAAGO5fzp6h1Pv8c3aZLYI1b5Ha+6WqGn+AtObD2BOptpzhlEYvye1XC+vZGWtw/FLxvaWp0FSaEBWOAzEg+9Gbnhq+eNviVAsvVHELVVGS0NwkJMGzY1msdye/HgUPNu852oxzD3hDDu9+3zVd8D9QodItS0Jow==;25:lDG/iUDgeFD6NbZeygHfHIhb+Bw7LCE2H7Ot9R0mJdL8UrafXAHm1883sfCZh1jYGMRevi1tHytYaLl2xmAqhr5mZaI48IOCtCnPuOtjVtcS4MSa5FQUUvpbR6rcsqSVFZAOe2lR4LwbrVbDk0uyhV0Kv7AWJe2aMTIsTj7OXgzK3WzNpBLZestnpcpNQGU4yK9sV2H9imBW/mFpIT/cIVXfUN5F2zybMZzRoU+NNDZG0auCh777KV+thgh5nVASYm8AgfV2bfRZGTAX0PneDpqVocb5XpfCcrUt13ryIWlf7T/xGD1aaGsethujDJWT2+xEl7nD5cwdQG3xab/l1GULaY+txkD/rVfmjpAiqOTzsRkzcrB5IyRjVgRRitlfh93NamdQerkJRtx/sqC1jJ6L3lpJviNusuZitVFiT7DZxlorJ4icp7lozIES3OD+mlH4ujAN5Zu5hftKoOHXSB9+plINXFBediUXTarVhdM=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;31:DcH5M1IaESvrbZiFsBEtY6SEq7qfOUcgM7WKtTElsofqnEdqjwPERm6+4vHNIYOeCjY8mEmBjP7XaItyFD79UgERyehI1q1h72m6jkpMVwZi/Sod536KZ1SQoh3hNM1dNDnT5VNSFry6z6F2yI7FX8zLeV2ms7FIrJJPiid0Nhm45ZN6Pq2eyF2JGDIV011MS4M0Onxcg4OSirhnsH8NA/QolMnidwCEnpdm7R+r4s4=;20:TrzJ8x4940toVvkSrb+jRbH8cPvc6NWIGfhdquf63wCgXF7F6S9LGXhfZRC7RRd3amOL0dC5ko+CV9XctHlbFxQkFRbsmPOfYV990NlA5u7HfCyxwPPRnRc95fYBFe7D+tnvi8QoZcc881oLLSUp+xR5KAUqlbG+0vfZh15nMFbObcMMb52UtOrrR+Qq1HFgxfm2+Ya4OqlK3ij7/4aKx0AUHhxKZlTiCh9cBlhQOhUIaKtTwhpwS0D4LGUrc8/OqQV62xnMpUWDmsB4c36lU9kGBanAvxf1EGoKA8O3gpqRWksN3VCALNSsBZ0PL+tGRS6GAHgbHP+bsUgHxcUru/1bunQPsUPZtS51/YVGQ5vGgjZGbvEWeMI6cRt/Rqu0q6Dr1P32527yLnE4LcDgLEKMj5xYdfsilv90d14bXMXsJfnxrxdteZ5HyC+aLd5Pq5tMMXtYCiU2b6bWvKC/NlkiBiBHP3t55snwTQEbEpxamtXew3IASd51a1oR5Oe1
X-Microsoft-Antispam-PRVS: <MWHPR07MB35015FF9DC308EBE3745872697C20@MWHPR07MB3501.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(100000703101)(100105400095)(3002001)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123562025)(20161123555025)(20161123558100)(20161123560025)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR07MB3501;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR07MB3501;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3501;4:DRHTYGr4TJ3y2JhF853Yfrve74H1dnexx0Ya5SX7vA?=
 =?us-ascii?Q?9f0qCLDVC87VVL4SPns0f+kpH/R4Vgg6saQ6gTb/Y+MACvRvrH42n/8acEPI?=
 =?us-ascii?Q?a6Ns/aZ7cEsk0AM5/nL0o/qD/EO/bcA98WUulkiGrJk4p9YARtBkLWqX5xY/?=
 =?us-ascii?Q?FcPjc+znVUrbRS5a40/gzgF2Y+Vh6VWXNLjj1rhvVh2vjmAhm7pSjFjQIwHu?=
 =?us-ascii?Q?Q9ZRi8eHuiY72XESKbHSsgwGbd/U4Yccj20S9rcOhz7VQ0A6j0BRg6xQ3dPK?=
 =?us-ascii?Q?x3iDOkL7I5yNMQVJO+UIFKT+y2J8BtqFAqGaWct3BpvWDZ3EevUHwd/Rv2vy?=
 =?us-ascii?Q?oWX8v7zccQmlJbr0W8NLdIKw57Ay07X2tu/Va6iJNRMDVtSWA4mnqm7iOAxE?=
 =?us-ascii?Q?+TuqKdbyIciAP0FzHlQsE84tDjmbr2rlFG8Sms7naIbh2peMOxpshnSCWmiL?=
 =?us-ascii?Q?YvF+5ggYDMYSmIOBGZTIBd6qNazf3jeEYgTwaGOkjpUVa6C9WcXojhg+gYR4?=
 =?us-ascii?Q?zrawTGxX7DUGRv5Kq8I484/4CsfugLW1h2XjOYb1SQKjiwGNQl3pl2DFzHvK?=
 =?us-ascii?Q?Rb2oI+ysK22zKJxV2uk3ZJv0lHKOIXH/NutwLBLy9GIiAPuNx4ANsDS5yqmz?=
 =?us-ascii?Q?9vCG+ViGgQEte/0kVTNQXiN9enwyOXlH3Yd+oGMM015IW2/elSHicS1QISeo?=
 =?us-ascii?Q?exFiW5E4AvfLzNslkKWPWbo08e/RJefx7k/SfXp7mA5vLNHjraAZBGnMndIj?=
 =?us-ascii?Q?siRH4tUhmXTxUHHaKQBbJjmXdk3cLNY689GxVlerQ1unRXvqvNXpMYmKc8Y5?=
 =?us-ascii?Q?N6rzMKjaweTaDearYQB7bJfIKjV15JLowYhqab6daQFCmBTyGyyuLJQPxpxX?=
 =?us-ascii?Q?7KOVIa7rssNCXYc2S8aBno+x/j+uRUAJ3ekKW2MUITLrMwGevp/Uc0ehzUj9?=
 =?us-ascii?Q?pvE26cNoLbbpuuHrHLJKR5otsPibD5mww+X5EBEhAsqsktbtLwVxQQ/Bl9+w?=
 =?us-ascii?Q?7cctBBcKmNgSzsb2RDRFLWDCgcm1npFs+5pwhrN+UeqvYK9xXuIcsr7Z4eXB?=
 =?us-ascii?Q?VLnyFIhWP+s6FaC/1ShjbMkx/NNdEl+KopEcoDFk7H+h8tX82qKOtOAYCghv?=
 =?us-ascii?Q?lcBo7nzVRtAZq/e81WT2cFVBGqrP2F?=
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39840400002)(39450400003)(39410400002)(39400400002)(39850400002)(189002)(199003)(6512007)(105586002)(53936002)(50226002)(53416004)(2950100002)(106356001)(4326008)(189998001)(6506006)(25786009)(42186005)(6666003)(33646002)(50466002)(69596002)(5003940100001)(6486002)(48376002)(76176999)(47776003)(7736002)(305945005)(1076002)(478600001)(101416001)(2906002)(81156014)(8676002)(81166006)(72206003)(107886003)(36756003)(5660300001)(66066001)(38730400002)(3846002)(68736007)(97736004)(6116002)(86362001)(50986999);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3501;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3501;23:2tVakW8euONaz+hokt6ejTniUjLxEc8/KP4bHqzba?=
 =?us-ascii?Q?BAYcsnDUNeStw9EFkOm8JTCcOJZY8/Ywd6dvURXL6gANRANljD+gevMKJuKk?=
 =?us-ascii?Q?duLFJqFRaasifcU+pZanvhUityT7m9zq/slq3wXot0Lv2vzZ/zeYx42UKHw1?=
 =?us-ascii?Q?+1TTsKNoo70sJsTE7ijiFNu+EeS1Fmnv2JtA/a6LBQWmbp1rVcjKIba1mex3?=
 =?us-ascii?Q?aHsT0tjKZ7ZMc41ACQJG7Se8s99icw1VuKgbsh8LYLNOLUiJlhEz/koxU8s2?=
 =?us-ascii?Q?zPkhqdLrvVKjSqPFEKisSYdS1NeH71wKp8QJSZbxarmYobYBNPWp2r+6eoZp?=
 =?us-ascii?Q?LkbN0HrLZGnoraTZ16bIHLXEHqopni6w+P93vzC3YkbFzdb0KQfo8fWqzWKt?=
 =?us-ascii?Q?4Tj3JwXWAvhxs/WRRnY7Cez0G6XgB2gZhOA2UTfevwhBRO101YjXv63NwSUS?=
 =?us-ascii?Q?C84Pp1JvBNbibvLowexBhPyUBDzuEYSLbuYjaNzmusVRPsk5Li4v2Ynkjbno?=
 =?us-ascii?Q?Rrd2YEJQ621NKaCkpE4/6JJkOFeQQHQKRLGcIcSwkBYzxRVdkIO3PtNB6VH7?=
 =?us-ascii?Q?PvTAh46XrDlk74T3d6EgYocyA758VPmzha1xC1TNzarHkgOgU2eThJzG2UOE?=
 =?us-ascii?Q?0Obf392F0ZIkbFQ6Mt6pTZ8S4GUmUazfSkr2Rtv9rbW9LzhrS2vzXChxWgzh?=
 =?us-ascii?Q?qS9lc+ftZUpuwZGOM6/KwJ8J88fU5lawYV6POrN6kKwOTVaSs57rbDCbYnQI?=
 =?us-ascii?Q?ZnV5rDYWs58nn6i1YJS6gR3e6lm9Z1ZrKPoSw3n780qcn+dCXaKYpgdXipdK?=
 =?us-ascii?Q?qkacHb4a9xx5TtuGq0pm7AmCSh5sEzdzmgF4hRm2HCp+7KkTOQzcf7p4MgfE?=
 =?us-ascii?Q?16aLAZvVZEoouoh39LIOlCp9FIC2p6Wx1wkBYeE8h6SnQ8p237rmpg3WTY7r?=
 =?us-ascii?Q?DZYAK1kFutsGgklaR6IyazKh3FElDFyVhvAe3C16qroCg+aEiI0J57NVHIQ4?=
 =?us-ascii?Q?anReUb6nSTXz7ovjcc7ilVvrqI+qY5TbLRLrhqgHWfUqtWExNBxORmrbuvls?=
 =?us-ascii?Q?tZDonPAZaptyVrG/fzFjGu/A0FPQrdC/Ppa4dB9kokGFB94n6DOg4ZaXH7on?=
 =?us-ascii?Q?pOUETiu869bINVQcppDX0jZfdfYEVAyhbGN2ZUEf36Bki2cAfRlq6BZL59cG?=
 =?us-ascii?Q?BggSAMSACeJFDMH5HOnnpDR464OPFKU7+7Vn/vQrBRL/hb25Is52X8Cm8yOV?=
 =?us-ascii?Q?MdK64W8CIkO5/IP29Q=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;6:cTUhfahYZFS5CWo62uduiealf/W87dBazfEofTWUOvbmj0xn6dY2RcP18QqZ/RF2IxbcRNitjqZp8B3InbfukSREAV5ljyHU0N7mJ/qucZmfDaA31Ofynet1OHr2rCfW8+wa+4GUv/V3d4ThalZqkpiGUF0o+FCUxt2CicDiSGKi3iYgMv8t1JuRSJ8n3IbT7LVtVYmCWwpDY58zO3hUvzd8m3nN0a36gsQOshOzyxgxgcE6YIdk0khb5r8KeEG0toBI64XhFNQenfC3UcPNjyrjdVKNQLP+3ww14ILx4Gj5O4M9XS0gAdoICNQTg9jzDIrr6InolEw+7R3043pvC+nyrPWNYNs3fTM0KNHhNEc2CoYJJmDfr3su6fO7X3Rx3/KgLra4LYMKsTm6C7H9IMaGGOm71DSdP37mZ16oGL2Q81dpzuLplOfYi/wdip8umTO4rXo8IhIrfTNvsoy/90OL6m3ZCDlcPH7udTxUp393gabXtsOeEnmkF5rNRYPuPApEbjq54XkBos547He2/g==
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;5:EZmXFqQXKwCGgMZiBg0pkkYJe1334tkdc+x6v7ebum3Ok22LqUigRfghnIw75/o+gpxxAO6iEgy8ASG787zD44TzASIqFOr0fKMxG8iTBLp/Wh0VHtp7J357w9AgWegs6BCtDNGNTY5J9trqgNwo0rvgTZHCUOarXtYla4EZ6fNCEWjSef8LlxbM00cHWeGUDx1zAnxLsWAskebz3XAzXP8p4gV9F2vtcL1RUH2CkJBrHkvxnWNcijoC98iHSzbo+WLa8BNGRRQ8rdH5MaskmIFKiEB2kFEQxF0o9LefN5tpBradbiYG8iIetAwbjttJ3ryZ9TY2Z7mZyIJhz0uWPAhDydNctAo0yeX1bQ5mk8IApXXT4lmN3Q0E+D6UX4/zHDznSVlsNIroqyoNo659z1kCU/uyYSPobUdxrZggLzoAdKjaUA42RUWIff9Cepki5ISn7/v1CBeKuTk4ekn6QfIFXTzJ/1LkfL0DkQalOmZVzY9rDIeWvp+E5tdIuO+J;24:jJT7kmhriRly4S+2ieNHeivxMLbYDnmia15AHDL0bOUDvsbOodkCPsyrszqvvjE9LwxnTQVGLFjrRitJvpUxTva0FV37yVylzGG3kFx3M5Y=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;7:YSDUvbtZSLMktfgaVvwOlfk13Y5dKUeSTUYkwuh52pkqHMjvS++cLw21+GxkJuZFAQPIQPc3LxlyAdWXzme+aYBnmkzaHJ+dWxiSFPD53KoXHH/h/uzvNscYHd+PopXhG7/bQLlLA1cHUmJ5oHOwIjiO5Hy14FGkGaRnuFMPiK45tOaU8zHn8bi4Pg/oN2L9nPEne53GJsizLcAUauefShDQrIvHKapq0OE4Ly+lsITimjAguKMeRCv2yLb8zlTNywzdcssLMDinJzvfGIL0Vm+38lfJy8iHUqJrSOL2PVaEm7wGNjjcEX/WEviHT5RoSsX/eesuJ7Y+4WtUQE/rwg==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2017 23:49:46.2754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3501
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58436
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

There are two problems:

1) In MIPS the __NR_* macros expand to an expression, this causes the
   sections of the object file to be named like:

  .
  .
  .
  [ 5] kprobe/(5000 + 1) PROGBITS        0000000000000000 000160 ...
  [ 6] kprobe/(5000 + 0) PROGBITS        0000000000000000 000258 ...
  [ 7] kprobe/(5000 + 9) PROGBITS        0000000000000000 000348 ...
  .
  .
  .

The fix here is to use the "asm_offsets" trick to evaluate the macros
in the C compiler and generate a header file with a usable form of the
macros.

2) MIPS syscall numbers start at 5000, so we need a bigger map to hold
the sub-programs.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 samples/bpf/Makefile       | 13 +++++++++++++
 samples/bpf/syscall_nrs.c  | 12 ++++++++++++
 samples/bpf/tracex5_kern.c | 11 ++++++++---
 3 files changed, 33 insertions(+), 3 deletions(-)
 create mode 100644 samples/bpf/syscall_nrs.c

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 6c7468e..a0561dc 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -160,6 +160,17 @@ clean:
 	$(MAKE) -C ../../ M=$(CURDIR) clean
 	@rm -f *~
 
+$(obj)/syscall_nrs.s:	$(src)/syscall_nrs.c
+	$(call if_changed_dep,cc_s_c)
+
+$(obj)/syscall_nrs.h:	$(obj)/syscall_nrs.s FORCE
+	$(call filechk,offsets,__SYSCALL_NRS_H__)
+
+clean-files += syscall_nrs.h
+
+FORCE:
+
+
 # Verify LLVM compiler tools are available and bpf target is supported by llc
 .PHONY: verify_cmds verify_target_bpf $(CLANG) $(LLC)
 
@@ -180,6 +191,8 @@ verify_target_bpf: verify_cmds
 
 $(src)/*.c: verify_target_bpf
 
+$(obj)/tracex5_kern.o: $(obj)/syscall_nrs.h
+
 # asm/sysreg.h - inline assembly used by it is incompatible with llvm.
 # But, there is no easy way to fix it, so just exclude it since it is
 # useless for BPF samples.
diff --git a/samples/bpf/syscall_nrs.c b/samples/bpf/syscall_nrs.c
new file mode 100644
index 0000000..ce2a30b
--- /dev/null
+++ b/samples/bpf/syscall_nrs.c
@@ -0,0 +1,12 @@
+#include <uapi/linux/unistd.h>
+#include <linux/kbuild.h>
+
+#define SYSNR(_NR) DEFINE(SYS ## _NR, _NR)
+
+void syscall_defines(void)
+{
+	COMMENT("Linux system call numbers.");
+	SYSNR(__NR_write);
+	SYSNR(__NR_read);
+	SYSNR(__NR_mmap);
+}
diff --git a/samples/bpf/tracex5_kern.c b/samples/bpf/tracex5_kern.c
index 7e4cf74..f57f4e1 100644
--- a/samples/bpf/tracex5_kern.c
+++ b/samples/bpf/tracex5_kern.c
@@ -9,6 +9,7 @@
 #include <uapi/linux/bpf.h>
 #include <uapi/linux/seccomp.h>
 #include <uapi/linux/unistd.h>
+#include "syscall_nrs.h"
 #include "bpf_helpers.h"
 
 #define PROG(F) SEC("kprobe/"__stringify(F)) int bpf_func_##F
@@ -17,7 +18,11 @@ struct bpf_map_def SEC("maps") progs = {
 	.type = BPF_MAP_TYPE_PROG_ARRAY,
 	.key_size = sizeof(u32),
 	.value_size = sizeof(u32),
+#ifdef __mips__
+	.max_entries = 6000, /* MIPS n64 syscalls start at 5000 */
+#else
 	.max_entries = 1024,
+#endif
 };
 
 SEC("kprobe/__seccomp_filter")
@@ -37,7 +42,7 @@ int bpf_prog1(struct pt_regs *ctx)
 }
 
 /* we jump here when syscall number == __NR_write */
-PROG(__NR_write)(struct pt_regs *ctx)
+PROG(SYS__NR_write)(struct pt_regs *ctx)
 {
 	struct seccomp_data sd;
 
@@ -50,7 +55,7 @@ PROG(__NR_write)(struct pt_regs *ctx)
 	return 0;
 }
 
-PROG(__NR_read)(struct pt_regs *ctx)
+PROG(SYS__NR_read)(struct pt_regs *ctx)
 {
 	struct seccomp_data sd;
 
@@ -63,7 +68,7 @@ PROG(__NR_read)(struct pt_regs *ctx)
 	return 0;
 }
 
-PROG(__NR_mmap)(struct pt_regs *ctx)
+PROG(SYS__NR_mmap)(struct pt_regs *ctx)
 {
 	char fmt[] = "mmap\n";
 	bpf_trace_printk(fmt, sizeof(fmt));
-- 
2.9.4
