Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jul 2018 01:04:20 +0200 (CEST)
Received: from mail-eopbgr690104.outbound.protection.outlook.com ([40.107.69.104]:15514
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994606AbeGCXEHmL0Ie (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Jul 2018 01:04:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jhd8lG8AQaZzBwppcGriCoaVA0uPMI/5iMfk3A8c2XY=;
 b=Joq9aIq86O5+0Ni0J2lFZ/9D1O5O33IriyH9JUuHufqTedZyGAz8i1yH0iEGt+ROsWo+DF6Ml/iDNH5mdibCMMrUbnbg2AsSp1E2opaT79gHlThC4RwiBULUxSev2F+jtRrDav5jbtyADIKJHbyvlusS4MFrKaSZPbCClDBOnx4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.18; Tue, 3 Jul 2018 23:03:56 +0000
Date:   Tue, 3 Jul 2018 16:03:53 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     "Steven J. Hill" <steven.hill@cavium.com>
Cc:     linux-mips@linux-mips.org,
        Chandrakala Chavva <cchavva@caviumnetworks.com>
Subject: Re: [PATCH v7 0/6] MIPS: Octeon: Clean up CIU header file.
Message-ID: <20180703230352.d7vkjl3qxx7rf4zq@pburton-laptop>
References: <1530654265-26949-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530654265-26949-1-git-send-email-steven.hill@cavium.com>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR19CA0077.namprd19.prod.outlook.com
 (2603:10b6:320:1f::15) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a7b7634-c3df-437e-e941-08d5e139410b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:tShkQgi+HEuco9wExQi6e6GZmu4KX4y2DenZ9Wur0qJGteEayrpZWNZfBXmDssFlukjIXTRfPEzvW99xTdALlEZWqvN+7R/mRDFGQbkB7QroV4OsE7oy/himTipAlMCGatIx5rEq09gR/YTEuspb2GTvNuNu4kO4mNDwybZ7p7gyV0jGst0TVOGQOUoGvw4juDbdQCJrEeFWNak6gnh08b/Zq9mMSDcZ04TyuRBafBBwA9qgCienkeFIbOoMLmtA;25:YSx/GxfAhKnUT1cVwNXhOfPOGXYbQZXUzAbe+4YXYwUVlxtOZfaIC8bDCYW2NNwvN5IfPJYZHlHTwRHFBd8GRN9V5qCsdaNxw74fn6UTrnaK1tYlDi4rJHr28hr392c9e5Qvzk8sGd5kSGNppRnNSbxltat6OEnVML+dtKxumkOOkh46+A9pXeLmX5E60jhrIIz6ARCJsjkNfxwBhDugG4UaqwPiVGP8aMnrrDunGMmg9CwGMH8xrEcxIf1oMI9nCJ9K/bS4ZTGE7XuOFPcIHO67CFBT0k+yeenX4FoDZdpCHhfYG8FmqVuIGmOFskCR9ynUPv4A8MUaWDgWGi7GmA==;31:jJeDqgcHVp5+tKJO5jc48LR0YYyJEQPsJMmKeeES/3lcKDIXR6G2sVd/f6b7iZ4ARrqwaXMLb3uApKBUOSJV9T/M9ocwxOS8q39WAq/UDL/1959KNVidlda2pPH69AEY1dMXokTIKKR6YURQPbHm8j5t2QDZ5o9mzZd9W/3vElub1c4K+E9dtXdYKn8ulUl5mDxkTU77S2aTwo6fLBdVhNSi/wOsCHTpYBEmrUTstbs=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:sTCqvFtQpltvRnYxHHOWEj7rS3lbhsaA9CcHsQcpz8nWfhiK7zpocFrJPIIKGMn4bCMd/hQILzVMVl7v1f2U2En/srXARLFKwaNqTkIge8QW/vonsWsXzUrvMS3h2BMdx2N4m/JLT9yBqjuTO20rbjtNhrBFTWUwSvd4wvPTpKHDjJgEvPELhGtAHZQH2yqnzJaPz5lUC/s+oRYe9uM/gUwe2ITIZEZCnYUMeigoWroZOICLREBYAHzGcklpmYc6;4:LdPNkCNJrj96CcoHtPxkdVP1dBIpgJlhyEX/mwm71nqJFr6dQ1DBGvIY/IP4RnRNh6wVK3ew1oE7neq+a693CYI14dmjMzQGqI9UfOzW/Z/hev5pwRgW7WRrRvUw4Q1K32Com8dW9NGa3I0/t3iKOzUp/r6HfZqf+aGqTNoABC+2VqZtsitlyVjDd5GrCH2nlWzGS3Fuk5ENIiiT+Nn/+cgi31g9Ov2PakVDVOozwlATxeQlzqnxHeJrwMOx59UlmQhQTuz7ErWnaYZwnU58qg==
X-Microsoft-Antispam-PRVS: <BYAPR08MB493495B585D760A0047B6649C1420@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(39840400004)(396003)(346002)(366004)(136003)(376002)(199004)(189003)(68736007)(4326008)(5660300001)(16526019)(76176011)(8936002)(3846002)(6116002)(33896004)(7736002)(8676002)(81166006)(11346002)(81156014)(26005)(305945005)(1076002)(2906002)(25786009)(42882007)(106356001)(105586002)(6916009)(52116002)(956004)(33716001)(186003)(446003)(23726003)(6496006)(386003)(476003)(6666003)(486006)(316002)(6486002)(16586007)(6246003)(97736004)(76506005)(44832011)(9686003)(50466002)(58126008)(66066001)(47776003)(53936002)(478600001)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4934;23:ao0/PkGQR4ylpM2Kdpsb+omR9APv7kdg/iTh1XLWv?=
 =?us-ascii?Q?Sy2RxVXvflu6+6Eiu/17bGJuQ150D+bQVjYPBXaJRjT5YHIGIDdgoANv6Eys?=
 =?us-ascii?Q?QB54bOGmyZn5bDs92fUp6wbmO3NjaCsXFONOkxvWBFe2O/cYXzrToS5g3c6y?=
 =?us-ascii?Q?X7Dib4QMJcrdq2gmRg79WIM4gzz7IAHHGSWdw/RKVHILyZu5ONzRYqt+D/j7?=
 =?us-ascii?Q?8zFRBO2heI/+xEkwEfb1iK7XayJ5l4+Q0f4DeqsYeXkeeCDPJZj+YM/YbTMs?=
 =?us-ascii?Q?Yssuw8+b+3kEI71PHmiscKTgHhgi/luvLiycy3dVy9LCRvS9Ou/JycGyaZ8/?=
 =?us-ascii?Q?NvuCu4353UwmyRm5n6Ypq+Ed7Uiv+vTSzdycXL9pBK78uZ1oiawtZt67U3HY?=
 =?us-ascii?Q?s3wT7DdDLdPlMJe9wbl+ExWXNZ5xaZdY0/8HbZEseaRQhCZ+TgfCFJdnUTZW?=
 =?us-ascii?Q?Q5Vev5QoIDPdrAdEbdno0GXAxdZW9AH/rUSIwqQB+/+mGshbkuoQYXlfSvxq?=
 =?us-ascii?Q?0I8Tjuvzx3rOBhf4uHEB4E3i20UydiKfPCHFbR3W40He8sBfWFAGsgRPCIis?=
 =?us-ascii?Q?s7Z+ArtOYy/zNLVKNRz/gjwdJGWXruvS71f7jzFJUBoM6zpOK1HOxV1HjSKx?=
 =?us-ascii?Q?xYGtBK2Ns5MJHAXuUzR2k0ipH8E4BOXmint+/IWQtTDC6mEC8gcYEYE5/khC?=
 =?us-ascii?Q?6nPZBhmui7RayKuyUIAMAIAt/d2girwsfAM461gAFMlvgvhcuS/6X7o0dH8g?=
 =?us-ascii?Q?Kx7HJIPwfFpNY2IiN0BlZG2Gpbx5LHCHsuJEG40UOdLLZXUoX/wmk/VqUVon?=
 =?us-ascii?Q?F/Er/9o+Mvo8vn2BRBd+ShoQXdYbxeiHbdenI3Kv2pjdNHqjfyHYujJ1PeMA?=
 =?us-ascii?Q?AgaLEDbUK4G1LV3XQ8/O5/ivCSpe35WjZsxtL1kVSxCWNL2EMu1v+Z560Gh5?=
 =?us-ascii?Q?matyJ7jacYsHR0bLFt54LyQsRUpDjPw3ZKZU/6AYZvAoU5+aqwM5bISb9l44?=
 =?us-ascii?Q?yJdUyVzfH6IhDmv3amdvCtCMmxQI/yhz1QSXrtrEZ6fo5/+L6fA+Xz9r4DyD?=
 =?us-ascii?Q?Ghp5rGo1kD6ljqrC148Q66BOkjljx/mMQmiksqnE5aE8P/OM+UH/NIxCggzA?=
 =?us-ascii?Q?8Al3+N7tDTW47rMumQtrXS4UHy6nRemzNJYkJ1QIPM/IWIAA/a904blgzqrz?=
 =?us-ascii?Q?JQl+2sN3j4PUn7W/vvc211oOGpTwVsyFN5RvB3nUBlTxg02Z4UUpY4T1E136?=
 =?us-ascii?Q?IDnOSjfl3lAJNB/ymcw2sZ0MZMeL+oPbeBt8EJFCs1zTDYrJfR9SYDpZcsN6?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: efpC8aOniiTxr3maoDnl+2c3WyQQoWVp99apm7P2stm7fQthxCOfnmW3X42v9krWB6l+/MZlcUJuWI3ytvZ+vD1tN4lU7HiLSzxSjYoQlSLL8ma86+8wMlqTYrgOYREWdhWY/Gc1SPARG/XTiFFTniS5qCiIqJbZBVQQUIy4ViS563nt/eyBe7yCK+sUVRFJnqCabCYrQ/q6lG02Uus/z+PHIkXV9Agge7cZ3yJptRNjbIRzyqiUOj389ltG0URMR/hqUhq8F0oOEnKd8NwaGsliC5mhMczg5wWQyfW1sy8GSGxRpsCuhq5snx6hTP9tSY/MCd5IMlnKiWywSDQLeYnV1KBGnDfapNKtTL50qu4=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:dqzh2HQGcMdxDjpWaDCJorE75eBqcBVmARR10eu5uWubWVuzoPEGmG+FDOq+lyZ7UvPNW6r2OXaipJbouRIyJz0AGRGatlzJwo1F26gLiJRwbsUAPj2hJC+MR/quXC4d94VEeIgOpGn9B6shEDGLsJzDEL5Q8KtkonesahqMg1x8FUkqOfiU5dZXyZmLC/4tiwqQ0EZD2DS6jcowncXDXUdnJZHpVqqpsj/6ChrHJJ2pTKeLMDBMSZxDyc1/3zy2rAd1OwbqG6i6ws+gT1Pv604qf3JAMJwaB/BIPqTvmV/TU+8FGdzrU4wWLWyLOwP+BEHBdBvA0uq87HR0Q2DKYOTmPQVZ1auEhlF4FYuzgOayYW3mHudoDVFYkCt2WvpGy2DyegGxYSKCUuO+NvDwDTAkv8M8yjd1pYEESOMJf3OCZa3VIXv3gULdOO5cw0Tpv60J1GmVfBNduO6vaWNMrg==;5:ajaFDtSsKPJts9T2npY+WGtrCDbAUunYlgZIDdLoHlvWi80oJ115TcFB5zssRaHqch7pgyTpXH+ojeGcVBp/tGzMlNLphtrM0NZi3Gr2P7h4lX2P+hhmUs0SWmkIS2CyhQS9PLvZtTL9AzSOOkY4nQACPl6+M2XEgy9dVUSrrvY=;24:tPGQinQfkkteOkgFiFXI9S5AkkzfZ7YEGgSgNx92vb7KlcWgn1HkoX0CPJeGZujyQGOIoWqs471rdWXoKj9KK3css5LW4ppCn8uhbXHkroA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;7:kNpgjNmh7T1tdc8KZzKwnOuI9dM8X/E8bts7Q91CAhEqCH3zuY5Z7B8zwQ7O4KXttn5jgGsCJOFseqStUgZbtJ8/0tgeYUzUASkjlWCWzAmYE6YzorwUjAh1IaUDpvrPesJoKbcbvrQgidkc/uFZKnNhod6B85kFNxgNbVISJySFxN9RY6eSlv5TcSgLH6B1GtbS1QMANSSSGnSicPiqu78h3VfddUAwtVQEESi558k/W5JFJ/IKNSq0jAffZBXk
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 23:03:56.1947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7b7634-c3df-437e-e941-08d5e139410b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64600
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

Hi Steven,

On Tue, Jul 03, 2018 at 04:44:19PM -0500, Steven J. Hill wrote:
> Very large clean up of CIU header file for Octeon platforms.
> 
> Steven J. Hill (6):
>   MIPS: Octeon: Remove unused CIU types.
>   MIPS: Octeon: Unify QLM data types in CIU header.
>   MIPS: Octeon: Convert CIU types to use bitfields.
>   MIPS: Octeon: Remove all unused CIU macros.
>   MIPS: Octeon: Create simple macro for CIU registers.
>   MIPS: Octeon: Simplify CIU register functions.
> 
>  arch/mips/include/asm/octeon/cvmx-ciu-defs.h | 10062 +------------------------
>  arch/mips/pci/pcie-octeon.c                  |     4 +-
>  2 files changed, 114 insertions(+), 9952 deletions(-)

Thanks - this looks much better, and hooray for deleting things :)

Applied to mips-next for 4.19.

Paul
