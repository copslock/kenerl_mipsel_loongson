Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jun 2018 18:32:57 +0200 (CEST)
Received: from mail-eopbgr680101.outbound.protection.outlook.com ([40.107.68.101]:13599
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993029AbeF0Qctalttn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Jun 2018 18:32:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gZ9DvWWaxA16/jI9KpCWBoDEM5AsJpZ+TA1JhTimrM=;
 b=C2y0tU5Q/CaOd9ItP5tU/Ualpf2bbGaAyBvZDCRf+oQ4bDh5nqHggzvotGy2flsMKmuL63hctoaAHRchsScz6R9CeMrnLRnO43d4QXzQNl91iJaEJrTX2eUtn0um4bpse9LSaTco62/5yobzy5Pbf9qt7kHclrFBoZ4OKYqw7Xw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.22; Wed, 27 Jun 2018 16:32:39 +0000
Date:   Wed, 27 Jun 2018 09:32:36 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [GIT PULL] MIPS fix for 4.18-rc3
Message-ID: <20180627163236.tzqu4qszuxugsa5h@pburton-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ckx7r2xdzybyzve2"
Content-Disposition: inline
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: CY4PR19CA0030.namprd19.prod.outlook.com
 (2603:10b6:903:103::16) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 306daca9-3dc5-43c2-59ba-08d5dc4b9968
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:nZYzlbezET/RK8kFKOmD3WiCC7wA3hNMvnZBvxtTBwKd3Dsf2HdK2Tm5kTSSGlKTBqTOrfe1B1vb/zNFznbAOUcCIqXLcIufCZ4e3UyeaIu1/9/wMNb5XhWShsiZ5BWVHFEfeH4lk7sIPzl3U2J0YMmCYP0lKjVaHqyDFGNmdluN2YSXH0jk8iqpcUokMV8TfDefQtuMgY+98BOakNtjxxglRQY+CD0TbXKAPg0yDhn//OVKRe7V/TaezecX6r5+;25:pohS+BrupNqvNa0pwW2VBnSol3Hoa8KbaNiijrd/ue+zKsnNYgU0cO0nnlzEbViwfjDc5U8gq66a6P582M4mFid7/f84kp4r44P2mRKQTkP2R/GfgjrVx8Y2AVWN0FewgAZJ1xz+jakE6ROrQi0ITNWOLa2E7bXRKJKPQvbXcvoo+CBoTLKXC0pyh7ctZBAVW1kN29HGSdy9XXaozPDpCHb/6skMU5PLc30A06mdg4GeZe6O2JBvija0DOlx69LKnALs4SjqoOc9Qr8HV/L5ug2tWr+ahMmobT50f28kcbG7rW9yPexMiVF23QadMho+rrwFiPTRobeqQLfDZF3mZA==;31:59w7OUzMwIi8nUl4dvfFD3ySom9R3QVg9vh6Gsto71KNdqtt2WuM3L+LO8TJJNC2L+c8DfKchxyY7Cxuz18peS3Q/26PiY8bA8bMHKlSoouaFZIQs/QJ8q1FLfb4PRp4A4Z/DJO6rXZMqgKp4LC5v0xvfOOvpubU+nVplnOjnXrnm1V9rT+eWCsdwQUTrKFXdEloPdP9QtwKHixwVhmWdjdGJnWtZrLO/vx4tFFJgOw=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:U/S2Uzz36Vhs7PFhFa5MQRSCL7UfbidXwWzMS07WxEA+9rh5yh4QR3dbgtBp4JyjVh2kMjKn/KU2rgHaUZtM4VoH8jhWVgPw5dRMIeMuq39E97Pq5BE8fTEfF6OUdFwWbB4zOyBpThi7vl3HhkszZ4fyQCFPc1n6SLVgC++vx5BXMySuawP1pb7FnoF8AYoN/520zphJoYYZR811CTm1GXqyHP1Pmg83yWJTOrEXi8cVpUv/G5aqtx+lshzipxNk;4:O7UmSKq6pfjxKv4WKxxjpa2ELcrt+NPmuV3cxFu/qOmreZcdIwjnMMgENCBRoXO42W8tPeP+IHFF+H+b0lwFQHkfE42k27qVStHutIkyTSNcVodmCRv/Ufxyb6peizS3UjYvbglryKxkcBfkWfkf9wcxosMYNWGmH8IguGFDltBuxN5Uo7POklbCe3NbJYJ/JXdDivgCFr/bo5TibrOzugmRzq9VcgahO+6z+zCneqrKHeBy0dktKWBJgOuywvDNjXJ0UYSGONSvw7dWXRMeHLokVqDxTRpXV5VyPOXbTVsiPU2Ah3TmquUqjlX1XJnW
X-Microsoft-Antispam-PRVS: <BYAPR08MB49345CE72150062F5061164FC1480@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123560045)(2016111802025)(20161123564045)(20161123562045)(20161123558120)(6072148)(6043046)(201708071742011)(7699016);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 0716E70AB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(366004)(39830400003)(396003)(346002)(376002)(136003)(189003)(199004)(68736007)(1076002)(84326002)(44832011)(58126008)(956004)(316002)(6486002)(63394003)(9686003)(486006)(16586007)(5660300001)(21480400003)(3846002)(97736004)(6116002)(16526019)(186003)(54906003)(386003)(476003)(26005)(305945005)(106356001)(7736002)(53936002)(4326008)(25786009)(6496006)(8936002)(42882007)(52116002)(575784001)(6916009)(66066001)(81166006)(76506005)(81156014)(2906002)(105586002)(6666003)(478600001)(33716001)(44144004)(33896004)(8676002)(2700100001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4934;23:8MycP6UFrbWdZtfCGGBjsYg/vF3s3xbj67NZb2qX3?=
 =?us-ascii?Q?CPg+17dXso3fdVoTk7vbKsEM0lcRhJNMTSvHjfj9SpwLi2Tzi+giool0F4/w?=
 =?us-ascii?Q?76jfJh5ifmh+j7P3IbXgSf8QW1TX2g2yygzL1ejROpexz7V2gBgf0S6FT7rg?=
 =?us-ascii?Q?BEoXGcsNmkU10IKFTMj0Z+9uDrhRQhAu31tcVlQyKtQNnnHXpmL35bLASmfY?=
 =?us-ascii?Q?gTlZmj+NtzNNpK0RDRFeXdtcfDX6ZumxcmzDk0WDicgpaZGX00CaqJ0isl+j?=
 =?us-ascii?Q?crX05u1LrqKz9GvnpDgKlWQna+QolcYB0bsD3271ENyCziM3a7Q6dt77UM6s?=
 =?us-ascii?Q?2UHNkECOACNc1EIPw5DBTQbaxYs4oJ4EZmqZjLtwBAixVSfMpE/7OXKvPg/e?=
 =?us-ascii?Q?11jiLJjuvWiwN5RRgfxJd6/6Q/9eI5tD2Lk7LkXAsqsplIj19xMaquLhB0wv?=
 =?us-ascii?Q?MdJdVdELzflNndxiaGNXtWvDzehmq4EP3Rp1bFuEFr7HVFgKLZ6YfXjwTF6c?=
 =?us-ascii?Q?HjEhzWsRyIddLDvb+7TRVTpYNKQC40X/kc96AWCboXXP3EzV4hsLIzGkbVIw?=
 =?us-ascii?Q?2clM6cZamCHXpydgZS5J2XIHxDhRPxaVa1BtQ9ZW15XvQmbYyoOMxrZIqDgA?=
 =?us-ascii?Q?tU/RGGFBv2fu4upm+dZ2hBbmNCvVFibDcd4/v9S1R4g67LxWVTQ0bWD8gQx3?=
 =?us-ascii?Q?Uw39xY3d+VwMKYDkN+kemC/aqauvqn1yeax5LGQLsXVcF970PTGc/8/+poSJ?=
 =?us-ascii?Q?jdWdGWyhNBxP/x0eiNOGIm5TIlnq5VUtOz2rVO34K+GWYHgI1xLJLT5FiQ53?=
 =?us-ascii?Q?5ZaMnkX0t4wvD53dhbrWsr3SmTgBCdm0+oyJi5/4bTm3/1Bp8qRIj+CCW5qK?=
 =?us-ascii?Q?NVEzbrDDrfqEcL51exCB1V7ICnU6SYGhaf32tCcJjzJS/QyeEotP2XMTLDx7?=
 =?us-ascii?Q?/8T+ypOp/oM8GYqNB5Asp5MtLXvyFPM0GzCbI+llPoXF0F7BqcfabH1n/rvc?=
 =?us-ascii?Q?BZ8IwTIJz776vuSOlp11s3WkSfcFcaHJkAlRnqo+nyW3/dvRweDhEmaL3uiE?=
 =?us-ascii?Q?wuuv3qAnT92mEuhuppTPnFTB4qiKVDCZBw3qrhrsOPKBoI2f3Z5M+Imqe1Zc?=
 =?us-ascii?Q?ju4OSc5/74/XUWZNwYVhaNwarhAs8gTMgdNy1A3AqumIWtvquerUGb7KwWJx?=
 =?us-ascii?Q?tLVstwCUrg7Ev9Y1kBChR67pyxBd+l2O9PlHeKUYjHcGXRORVUBHGZoyZJU0?=
 =?us-ascii?Q?W8FbUM1ZkqIeAT9RkZfkBI0zlz4ROYBJujdcLxEh8cJjJGj/j8Vy2fIhlZq5?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: 5aGFMGxh/kvb0dqXY2kbaLvKhYVjl9KzAh14dP8FlbDiZFEWSq5cgWgQVm9LZYThkkCH/7AIlAz4WGMvZ0OYvfWxvEbBdruzAn5Ffm4LJ7yU8BIwNA9kt/YnA61q5W8XP4Ks7lFfiTBrkAGhUHV9HL4I5aJoi6znGsQq3X8HakwTqF2DZly82p7WaXF7j5PjauXkx98mSDByGvJWZP5ORvB8ZFcPtN7/D6M/BszPg/Iw/CkPhDap68S7YM98/4NP+gHp+IhQAbYYSv3fGKimiKLLhaBZg61KO1VtNwwc74+mK9EXM06BAwhBJhWWSos7EkrAsC2zFmOijsfLOTMeobGtEKufJiaBrJw29X+BM1o=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:wZZsa+dd9aXWeHUBn4CecOHgSN8RDmTG9gK39w8JgNMQb/hiYZmrG7/lrIF/T9jZvROTNKQNwrAPhExq5zNSvZQuqqSVeDCiVvIO6AJXP7pqyzpL821/vvOUV34clEgzFYxOkqmYT+eIvLY0p+SFZfEM1Ll/lmVzj+Znpho9fd1x0+8KlpXmpcdttjq6Eity3/IJoX/IWWtYYnfDsITF3RG0t2C+kVbjz2iBOihhkkhxPjGsGmfaOTuRrpoXxy2foQN3Irab1bYjK9sYqGUGIN6G7u1W8bbhfXs7BTGxEJPtSPd9zvw7a2sjqL1IyiOQ76Ihg1QECSEtmo/m9yiTdysxEhRPOA4Uzb3ogRpKdKL5C5TBTUs2cAJaxOzsWyf7OgBugdZk4EWXjzLJdHE43jl/DKZX+op29vrsAX7sheuOYCYd33fAOMpy3epn0TmpmKybtsNN55efZW44E9iXWQ==;5:h3utI9yY/cQ4CLzHVJdyG9zXGQIHrK2lCQfufKVXB/D/A/IF+QPXzzg0+tfDs7sSJjs5LqTagru1476h+W2l6QZ7BgaPP7HOZwZTkikBAY9QGx4aBaS/oD60Af2VzGmZo1X+NjsrMi1aWuRO5SboWtCvN+2t7/pV8XdOKJiWJFg=;24:7Kfp5M+PcWyx9eelW+qhBRI4/aQqGzf2yexUq678cDICiL/08Qy2mfA8ChdxjXOpG4TxwXnmfdHTYmxyfmCQJQUOzJjE2E/oXZOJ4b+fpQg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;7:/l2c1K0Xer3g5+GktLy8eXGstHSvsQAxcMwTVi8zxkRbgUkL5jU4W4jL1TdkdoH6VNr3J2n0L0Z1/Hqj/Lo82qPYBYZN5GxzcpQ0folYYF7ys3moB3BfOJqyItYKVff3aSPEZXyoctB/VuDhaa52xx2N3s/HiXSLwmmBn1jbO3SafESkMo/rdmd150+IPKvCFWpxqvdV/tu7uSP4I+s4sdnxy5KiQOM5ckFF4MnVisWBQyKrDyH4ZRxm33mmYKfW
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2018 16:32:39.5641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 306daca9-3dc5-43c2-59ba-08d5dc4b9968
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64469
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


--ckx7r2xdzybyzve2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Here is a single MIPS build fix for 4.18, resulting from a race between
the introduction of MIPS support for restartable sequences & an
interface change which both landed in v4.18-rc2.

Please pull.

Thanks,
    Paul

The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_4.18_2

for you to fetch changes up to 662d855c66c0a7400f9117b6ac02047942cd1d22:

  MIPS: Add ksig argument to rseq_{signal_deliver,handle_notify_resume} (2018-06-24 10:33:03 -0700)

----------------------------------------------------------------
A single build fix for 4.18:

  - Adjust rseq_signal_deliver() & rseq_handle_notify_resume() calls to
    add the ksig argument introduced in v4.18-rc2, around the same time
    as the unadjusted MIPS rseq support.

----------------------------------------------------------------
Paul Burton (1):
      MIPS: Add ksig argument to rseq_{signal_deliver,handle_notify_resume}

 arch/mips/kernel/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--ckx7r2xdzybyzve2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRgLjeFAZEXQzy86/s+p5+stXUA3QUCWzO8JAAKCRA+p5+stXUA
3WYxAQDGYX4Z0FAn9T/auciq7SRVYhLHSwAyCnoXz4ZDRJvGXQD+LY8E6F3sYYUn
3LXRfbfgur/TphvkFQoErmQVQrAcQwY=
=vhnt
-----END PGP SIGNATURE-----

--ckx7r2xdzybyzve2--
