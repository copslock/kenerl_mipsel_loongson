Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 00:36:03 +0200 (CEST)
Received: from mail-by2nam03on0075.outbound.protection.outlook.com ([104.47.42.75]:37054
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994786AbdFOWfz63Vir (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 16 Jun 2017 00:35:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=nfZpwPQVsqEdFN5jUt6QwdKiYgrTWTOU89qQYxGscMc=;
 b=S9SDxvchwqyKCPsaUPfvJVvFDGL8wDMGAl6oZk5a5hjzm0uOq2jEPKg4rrP3X0+qyAVsb0WRjJFNIjTZsW3EHdzjBnTBwd1WbgoWb9/yBDIWTVRWkYkmxbMoo6trU/XpMVfP3P4FXd1yPx29tKMHfUTH7hgXMfdoWqfRIcR0euM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cavium.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3501.namprd07.prod.outlook.com (10.164.192.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1157.12; Thu, 15 Jun 2017 22:35:46 +0000
From:   David Daney <david.daney@cavium.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH RFC 0/3] bpf/arm64/mips: Avoid inline asm in BPF
Date:   Thu, 15 Jun 2017 15:35:40 -0700
Message-Id: <20170615223543.22867-1-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0070.namprd07.prod.outlook.com (10.174.192.38) To
 MWHPR07MB3501.namprd07.prod.outlook.com (10.164.192.28)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR07MB3501:
X-MS-Office365-Filtering-Correlation-Id: 60bc8fd8-01bb-4140-919a-08d4b43ede19
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:MWHPR07MB3501;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;3:/Xx1ljdMYqJwJb/74nk8suuAtLYx1pE9rbnNjL+/cf46C6S4I6leUJbrMu3Ft62i1IrJxH8TGRGh1ITRP6FMDZSYFCx53o+8XQbDS10+v5Igp7hjTbdWaUfMLwATxt/KBCtIk0UouqssTaRwJVjFhK74lYPpymHjrURFanOYXx7VE4fjs5c0UNLXlFH4NHfzzUdopwbmx9y+CmvJ9vX8PpT1Jzg1cB7VU9m38G8+bwWoTb1wPIhD4gT3SzCoRDKvVpRcfU276i2EjJG9Bh37XoCYIDfLbkSqYEWTx0Cj3tn0yoASrCWUPofFMuGl4c8LyAG22Kgtxwxhpeqh7Jk6vA==;25:ZzuQrL+CDFsI9KiUGUBNbnjtrapkqTa0fd09gvtnGW9z1y1N9pxsFhk704qKliaO0jV2WwmfYewhoskmRlokN9TRAROgEAqsbrsyLJD7HLakXdecGPdwvPnbj92gGsbm0uSzQ3O/sKd9bN6Bwifw6yHJO7k61+RSa06eoqxNFGJOyI5cVtDiGHcBurdQepgXU1Sl5tfW/bb1KGBTPkYbKwWApCuqSpSn23Ynzu+TKF4d82lSAtoz2Y/td4j+lhQU9kRg2qlJE7iPtcnstulNBKOfRc4lA8tFhoTxHlRKAiskZ/K5PNVVzor5nu6fuVlnVR57k9m1BUFYbGRSrMNCo3hEHqa1SwZFFpZ/xxTvJarg5yPNemm/yg2Af3wTRfxC0kpH5f/8sZp6IXWd4AmEW66sv1G+v4Snbs3ifwMvMxXsvAiUMJAm/BkCCC1jiRC0KvYawtFw9LCOcA3IvR54IKItj4YRSjxjyCjfIX2hIdA=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;31:4BhMo3iEbyXckHJtWTrdEDRK6+7bXeQB/6Prus4fYnAwIlSZ59ssxWFLeXEzdw0MPYfeAbuq3ROEDJrsSFSzFQX/sdp7LF0eQxeAlN3GsLLwyfOKgfb0IBPnh9hM2eWuAfECxMNssrV4k7nsJzRyRwpdm4sUGIb7Zs7Y+jaKTJCnAhgF4dN8w26Lb+QIfjEULIQcHCoPOVOFCUbBMPwnyrAUukfRCaY3J9VzhI6dwdU=;20:A1vCg0jFEDchgeXA2hAx200j3JX2t24C90XNzK0MAKRpSjQcTeTOfPhtoedaP+KAHy2oWsoXMgcyP4bZPEQeG5fzzobnhplfd95eagffZjO3AsqmEI/aWnpaAVeN0LVb2swfqz6Pcbca5d4zCdN13yNuPSIw9LXGqibNAK90gY7MAzj6uGIyyqM/yPDzE7mUINAd4GY7RFWgvB/ANyjXqoLIM5in3Bd6kt2ES7J9QtIV7fCqSA3HJjl8ubHZG+BNJrULLFp8cMQMwN4uuTt4ntFdbpXptXiKY245FTP+97t7hYG3KOgdEu3IYD1bHU8pD4O7WZYW8NEfTUKjTwQOVTuNehmcA7grVsHUhu3bVmDpsF0ItzboEXvwDDtSWSHbtkLDeoVh37MetZ7WDRaKqaKGvlAE/0ZTsHGgUv4JwfvS5W2DWAHBfUzG76epzkksM/32e3lEjN9XkXd0lMpJE3SNu75JqjHKTsFAvSpbp069aZ1h+BSrwScGkFufFuoy
X-Microsoft-Antispam-PRVS: <MWHPR07MB3501A31176A29F5DDF1C1B9797C00@MWHPR07MB3501.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(100000703101)(100105400095)(3002001)(6041248)(20161123558100)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123555025)(20161123562025)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR07MB3501;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR07MB3501;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3501;4:pTZt205x0LvgWX0IS08pfcQdcF4ah/F+yUaR47Dlgt?=
 =?us-ascii?Q?ZuemrJsXo8+HYRmM9qfqUXnp6m/TWqNbK0KZ8ZNCKK0O3oPqlF34MWlilWJn?=
 =?us-ascii?Q?sg5W5cAfsns8lPOA3rf8fVAIZhs3lMTXKao8wMuR60HaivO4hBy3k+gO/ydi?=
 =?us-ascii?Q?Ohyheql2uQmMH1FLYHMpmjmCH1gxA/BVwhKlfbk5i3zBHMSA6ouca1vyZLsa?=
 =?us-ascii?Q?tHu6dSWaPhxwzc6Xl00X+Bn7FFWNJvU2gkMAOXD1IWrofCNWiBEadJ6jsWRf?=
 =?us-ascii?Q?JNC+SLk8h1jK+jEtZBDnfrWrryzBfGY2MxEMoTr7vQiwbHJ+VYnlZQ3FASb6?=
 =?us-ascii?Q?Kk9ZAgypJ6WVtt0+v91zsappUBZli5+mD96dkwEuPxbCqrLkt7SGTZtmk67l?=
 =?us-ascii?Q?U/ebtObstmklxdAJ4uMBy1C7tCgdnK6Br4bBZTlmmntMAJifWLF7wm5CNMhn?=
 =?us-ascii?Q?RFWZxhfQzzcrWeCyi1jgcaQDm8XE2oC5cOXh2pNtXJJtPJoaX01+7PNYBc9m?=
 =?us-ascii?Q?ZYnTfvsHcNnvhCxeLckc1IWRfKNGuz/cGnwIFi+8sT0BOGx4h7Qx8OtTbvy4?=
 =?us-ascii?Q?b5YD9gAylEYbowkdiUHic7BWybfFMsmmSOd1XB9HT4i3iX5TWeACy8YTEwd3?=
 =?us-ascii?Q?fK6z//RvNSIdUOF0TwL9BT276Kh83yai9L8vid9Rmi4GzjshlQxXq9/yufoe?=
 =?us-ascii?Q?Z050TeOdmRYbGx0OXyQcFrGkqhOzFcYZqFYA4ynzZEUv16SNE17ktYnH0hSU?=
 =?us-ascii?Q?ybdrUkyWqhFxaWL3GDWMNvQzyTUjYkI54t6wCG0nyoQ0KpBIKza0+Ip5qdZz?=
 =?us-ascii?Q?EUjUPXvYjXMnGnlE+OM/7AMzsZoKBKOtuKlN1bSBuUQs7TjFvPMF+2IHGVDI?=
 =?us-ascii?Q?4RjNdzrBBEVcGjHrWOmH/ydOPjmt/fgVyhs7XgbJ2vJqWXNjiCOwXXtA3Q5I?=
 =?us-ascii?Q?fNxlTPn/xR7KRaWS/6vf43TKYMj+pcy1nAARNsN1qSk8S4DF1lVc07LoDGVl?=
 =?us-ascii?Q?L5Vrb6nyMrClczk5k50EE+cFqE9z5VfDwhIdKds9Y+4PWDqfVjQ0NeCrTDu8?=
 =?us-ascii?Q?v3CL/4lXipeOBfyuV4zIRUtzRj3HyCGCyyaKl04ePEaQfmP07GyArgM8MSVN?=
 =?us-ascii?Q?iLAKqTTDYZZL1+gY7AhCQwCNwvU6rx?=
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39400400002)(39850400002)(39410400002)(39450400003)(39860400002)(39840400002)(81166006)(72206003)(8676002)(47776003)(1076002)(7736002)(305945005)(6116002)(50986999)(86362001)(5660300001)(2906002)(36756003)(3846002)(38730400002)(66066001)(53416004)(6506006)(189998001)(478600001)(107886003)(4326008)(6512007)(5003940100001)(42186005)(33646002)(6486002)(50466002)(53936002)(48376002)(25786009)(50226002)(6666003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3501;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3501;23:7RkloDWSpxCL1I7YQ7zkVQCPjMXPBhWESJM7tZ6yV?=
 =?us-ascii?Q?UX7gstqnP6RolK5u4ICnLE0NWw/hQvSYzWZaN5iRqGjaN3iEyTfIBB80jqqm?=
 =?us-ascii?Q?HG8fGIICi2goktSikQJPdiAy00kSOKfDg/3dKGTmmGuG4Heg0gUYrlu19XoG?=
 =?us-ascii?Q?RGiVFiCFW2XBpCvxu4prF1OwM6SiXBb+1uwDdbNxSUjirICiCQZeZ/u/T3s/?=
 =?us-ascii?Q?9sMQDe4diOh4lczuqs+DlHu1mzsT+1COgFeAItU8EWEHgTZX5HWTApwIGZwl?=
 =?us-ascii?Q?d4cFYH6wvqNs9/oo0Y1KsiMmkqYboSHaBDooY5FKA24AmH9uJ+Z6OB3jq96T?=
 =?us-ascii?Q?cMm4kf4YxOSUiuaRIM0aZ9RNJ6CEt9zSk6IstbOScXTo5iLE951AehX1D1jO?=
 =?us-ascii?Q?PIs7OwL/q2sIcoOjQtTllZ520p3mkFlG5/rJha0e5Lo665oPcB7bbc+y7qXw?=
 =?us-ascii?Q?sVK6NCFo7DL0cgYvB+OsOjSlZgU4YxyLisSBTjFe9P5zmRBKu//5Gr3OKif/?=
 =?us-ascii?Q?iVi2skV75iJwDGAa/x2JGPdeH8HwjYI6O8mfiu/mJqGh58eMhhGm/mFCrz3p?=
 =?us-ascii?Q?O8NodSgbdf7A3iWq475I+A07jkPFxieNLapF7BHgDidXJb+hM+Oej6aCQgOf?=
 =?us-ascii?Q?xve1sIu2lBCNPVHJm/8BHuutcU0na1iCszOeyvo/RjyigoWO9hskj2gwzqaZ?=
 =?us-ascii?Q?Od0tchTam1XbWDg59F+uJZ9SOuNbggAtHSQgoUNZfUwteOb7d0bQzTIUW10d?=
 =?us-ascii?Q?+QJJQtgRYfpR2Kseecj9G90foBDq15F7skbXDNo91qondcR1xGkxzf1vipbK?=
 =?us-ascii?Q?1k6c3o0ybeNc7mSlBgvdP046xFYXKNeN0rqYbnm0IeRoSYFOVWjYdBTHUVGr?=
 =?us-ascii?Q?WP2hilDpUgeOePF3PBiVi1Wss7y1xjozgBNpCIXyVKVNdEcShVgopPf6pC5s?=
 =?us-ascii?Q?vz7PJWg7rPSBVOqsAMKJ7A87AHRG20/mUFlgmtJjz1GJ/tmkaJvSSPcrx9uM?=
 =?us-ascii?Q?aCAfbF5JAbuxrOXAVJLer9TCJ/s+7xEt5sn2OmQ9vs0xjKrcRqBcvt7VNz6j?=
 =?us-ascii?Q?vp6rDtciToiEQWwuSIs64Y2ob8j?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;6:OUCG3tvSV4SK0bzZgRreeTFn+xxq8ak6SqzzRUGK2El0FyoRZ66lW/V9yu0rNjVSoyw2nUn5LIHz38IYelemY3k1LyzAF4MI2DdHM+wWgYd2HLW7K8Em75RCgqloJjUQNDn9aBKdHLG695qh/4qAS2CN67bMomaGyZjRENxvLNYTaH9CJF51EfI5yrm+iaea0oEIyrH3haM6zInY+1isygca0SZg0tPdlntq3mC/05xQkBhJBN09rFb0MT5Jn1woQ9b8N72RmVYYaczvtPzHbe/viS2yGTyOEZIQSAJTCWi/VPLsSiM7iMCZ6aDSCe5w0vDS3S7gceShAwpuMsy4XD1YCNt8numXKjqUdLG9acb+DSU20auPTftIJ9AgR8Uy9PuoBQpXIqRISva2BwR0VAbnKKbm8SBY5yBrvs1KYo/KXM8ZWSWy3d/NWioNoqJIZtuBzfxzVckVTySoVKtnmm/a+Uu2sC5JOargRkkNo/Zv+yhjZV5MhsF5O6IrzTh4177uAwVuS23ax3bcqis+Cw==
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;5:z9N1y/cxJGOzMA47pbqYnwlP80UeRMiRtqsZ5KFfEc1QofnWpjKcxX6Ks6kFDhhOVFfl+5H2md4aBw7zY05AhqLTJ2ZKEM2a+l7g6tIHPSUPArrbqI/2U5crs3IVezmV+Z5WpnLcWXF/jhygkE2+EZCaT9M+AU+S1TDISNn0OfNYcgAzJ2H4tFm7t0LoJfwrqZkj8IfJsOzjqEQkVW53CESrLxyfnk1Qe3Z5LPLQD9nbXWcUnED6QI0uZ1bcuoxKTWu0+NvbzkveQ1UTVQPvraCHgeTe/dnPgH+beKrUybSI+X9yak1ANyu0erBDvUA+5XggWJ+e7+hjjBxIyZGXhU1ELb6pfIoeJusE2fBcVZKg3fE02XQoTTjrNH3/DZ+5i1zRrTt6Xnwlt2wl7Wsj10bz/+GLZMADasskOJNcZqCEzNBvuWZBa8gpXte386XScwXlgUByAGi9QHj+MJIIsjzZigMEbvNrTx2n+J8os/UCpTuSPsmDOUZ1mGMMKIVY;24:NJGb4RsyTiYPJWjgvSiKnJvLlvTPJfo+Cetwk+f4yszlZmQByBaN6I3BhJ8Fggq5FCKx5PSDiMj/fL8b8oz/a/o4dqecI8Xnl6qibdde144=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;7:aU3Of4fUKwZxFIZG7Wh7eRUG6ByxJEF1lEvx4K+t2X19dWhWZu0X2Lfx8uBl0RVAXLKJhr36cLZ6LwaTqVP/LrW0DJpuVoGPBjNu4HeG9kRjn0DJFUsNnL3iDmAF0v8AgU1SW2aB603Ca7F1CwFXDOQsj5E/6j1ydYTWALocqiqBJk+8BXWc5Pdoa6k3vVz7JYks71kAtMuJLey6H3gof+EGNZEAGQcgw+oUMmebw7mnq9ysAmEYo4BKtSr9qZVRmFF7QvbBkr0WV4tONwzjUKBpkMIk/B/bR6cbirglaDCV/v+XUTo7jtaQJk8x9T8hx/lX4qB6ihle8LVoZcnJMw==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2017 22:35:46.9834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3501
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58479
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

To build samples/bpf on MIPS we need to avoid some inline asm that
causes llvm to fail.

Looking at the code, it seems that arm64 had the same problem and
avoided it by defining the header guard symbol.  This approach does
not scale, so I invented a preprocessor define to identify the case of
building with a BPF target that can be used instead.

It is an RFC at this point as I haven't yet tested the arm64 change,
and I wanted to see if others think this is the proper way to handle
avoidance of inline asm.

David Daney (3):
  arm64: Gate inclusion of asm/sysreg.h by __EMITTING_BPF__
  samples/bpf: Add define __EMITTING_BPF__ when building BPF
  MIPS: Include file changes to enable building BPF code with llvm

 arch/arm64/include/asm/sysreg.h   | 4 +++-
 arch/mips/Makefile                | 1 +
 arch/mips/cavium-octeon/Platform  | 3 +++
 arch/mips/include/asm/checksum.h  | 2 +-
 arch/mips/include/uapi/asm/swab.h | 2 +-
 samples/bpf/Makefile              | 8 ++++----
 6 files changed, 13 insertions(+), 7 deletions(-)

-- 
2.11.0
