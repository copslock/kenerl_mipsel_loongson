Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Apr 2018 21:29:05 +0200 (CEST)
Received: from mail1.bemta8.messagelabs.com ([216.82.243.209]:7377 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992818AbeDXT26aXBZw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Apr 2018 21:28:58 +0200
Received: from [216.82.242.36] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-17.bemta-8.messagelabs.com id 63/5D-05522-9758FDA5; Tue, 24 Apr 2018 19:28:57 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VSa0hTYRj229nlOFycTcXXkYWLkMwNR4YaRaL
  9sB9dIPrRMPVop22wi+xssdAfzlyo6JyilJfUKKKUFCxJEaIMkUmmeakUQZ0latmkXzpddI5n
  Xvp+ve/7PN/zPN/Hi2OycqEcp+xWymIiDQqhmJ/0rppS2p1zmkT/jDLFXV8rSkOZgy9e8q4ij
  UBvyjPbcwW61lkPVtARbe/wuYXFqDqyAolxGVGG4PfgNL8CheJAFMJbVzfGAkC08WCoc1PEsV
  5jsNHv5LEsPlGNgceVzNaIyIE57/sgqYQH/Z6FYPOI0W31CbjGj2CqgrsuJFQwubC0YxhBHIN
  5fx9iSRjhRdDi2BCxQDiRBQuBUcT5HYeu0jEBW0uIdBh4toK4tEfhw6+SnXkocROaHA1MjTNu
  WTA/Y+ToUvA0fOezY4yIg64WGTvGmJv3epowTuUaOD8GhFwdC3+d0yLu/XUIXtWuCTggBgZHm
  vkc8AbBum8q2DhEsFTey+NY8TDhcgS/b1MI24OBoIcBfmw9FHH1GVjsGBZwpEYMnrYPCN0osf
  FA3Mb9uI0H4rYhrB3F0ZTlDmVRpqryLHqtzmok9QalOjFFZaRomtRSBjKPVuWbjd2IWYsQ5vS
  izvqMARSN8xSRkge8OY3sUJ751l0dSetyLDYDRQ+gwziuAImulMGkFkpL2W/rDcxu7cKAhyki
  JKdLGFhCF5BGWq/loGGkxGfvV1ZiMr7JbKLkUZJkVoNgSTqbaU9id0PHUYw8XIKYULKwAspi1
  Fv/x1dRFI4U4ZJYViVMb7LuOa0yIXhMiLLoWTaEldyH5MUoPbTpxLnFszeSDEXZE96+ukJx6a
  RLfTL3go0yDlWN+bDU1CsZJmNmc8nXrtkqU43giWCx73nmY0+Ssmdp2aAOXL6+lVufsLGGN23
  qLkWlSVd/St2ahCO+bdv5fm/6n7lvF5edn/PHZ8Qa7RdHzchoyPq0P+NUzyeHP3ulaCJGwad1
  pDoes9DkP6rouRecAwAA
X-Env-Sender: smtpuser@allied-telesis.co.jp
X-Msg-Ref: server-12.tower-94.messagelabs.com!1524598135!193249952!1
X-Originating-IP: [52.192.143.101]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23798 invoked from network); 24 Apr 2018 19:28:56 -0000
Received: from mo.allied-telesis-co-jp.hdemail.jp (HELO mo.allied-telesis-co-jp.hdemail.jp) (52.192.143.101)
  by server-12.tower-94.messagelabs.com with SMTP; 24 Apr 2018 19:28:56 -0000
Received: by mo.allied-telesis-co-jp.hdemail.jp (hde-mf-postfix, from userid 504)
        id 6D3A7294001; Wed, 25 Apr 2018 04:28:55 +0900 (JST)
X-Received: from unknown (HELO mo.allied-telesis-co-jp.hdemail.jp) (127.0.0.1)
  by 0 with SMTP; 25 Apr 2018 04:28:54 +0900
X-Received: from mo.allied-telesis-co-jp.hdemail.jp (localhost.localdomain [127.0.0.1])
        by mo.allied-telesis-co-jp.hdemail.jp (hde-ma-postfix) with ESMTP id B82801AC002
        for <linux-mips@linux-mips.org>; Wed, 25 Apr 2018 04:28:54 +0900 (JST)
        (envelope-from smtpuser@allied-telesis.co.jp)
Received: from JPN01-OS2-obe.outbound.protection.outlook.com (mail-os2jpn01lp0149.outbound.protection.outlook.com [23.103.139.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mo.allied-telesis-co-jp.hdemail.jp (hde-mf-postfix) with ESMTPS id A1991294004
        for <linux-mips@linux-mips.org>; Wed, 25 Apr 2018 04:28:54 +0900 (JST)
        (envelope-from smtpuser@allied-telesis.co.jp)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atjp.onmicrosoft.com;
 s=selector1-alliedtelesis-co-jp01e;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=un89mRzJjf3D2XUbsY7qqe/Xh5KiehTyiLpbfoR2ZxY=;
 b=VBz7P3eJ+rZ/BAa831+xOd+DbRDobiYBBX3ibP0dlC8TayA2002abyyww1f351nq56Jgr3uVsbmDEUoOgVSLwZwsEtk7iLKdxIXs/7MYVnP9RJ2tZX4IawiE7VQHSzkSdrgqoRIlgRWte1FCm5kxzSker9qlDdOY5qu1zlpQ4ns=
Received: from TKY-DS01.at.lc (150.87.248.20) by
 OS2PR01MB1276.jpnprd01.prod.outlook.com (2603:1096:602:5::19) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.696.13; Tue, 24
 Apr 2018 19:28:53 +0000
Received: from swim-manx.rd.allied-telesis.co.jp ([150.87.21.50]) by TKY-DS01.at.lc with Microsoft SMTPSVC(8.0.9200.16384);
         Wed, 25 Apr 2018 04:28:51 +0900
Received: from ikegami-pc.rd.allied-telesis.co.jp by swim-manx.rd.allied-telesis.co.jp
 (AlliedTelesis SMTPRS 1.3 pl 1 ++E6B86F8C687C6288D9B5559052954DC9) with ESMTP id <B0004090457@swim-manx.rd.allied-telesis.co.jp>;
 Wed, 25 Apr 2018 04:28:50 +0900
From:   smtpuser <smtpuser@allied-telesis.co.jp>
To:     James Hogan <jhogan@kernel.org>
Cc:     Tokunori Ikegami <ikegami@allied-telesis.co.jp>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org
Subject: [PATCH] MIPS: BCM47XX: Enable MIPS32 74K Core ExternalSync for BCM47XX PCIe erratum
Date:   Wed, 25 Apr 2018 04:19:39 +0900
Message-Id: <20180424191939.16082-1-smtpuser@allied-telesis.co.jp>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <TY1PR01MB0954C80E15BA87D03E3A6880DC880@TY1PR01MB0954.jpnprd01.prod.outlook.com>
References: <TY1PR01MB0954C80E15BA87D03E3A6880DC880@TY1PR01MB0954.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 24 Apr 2018 19:28:51.0074 (UTC) FILETIME=[7985E620:01D3DC02]
X-Originating-IP: [150.87.248.20]
X-ClientProxiedBy: TYAPR01CA0069.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::33) To OS2PR01MB1276.jpnprd01.prod.outlook.com
 (2603:1096:602:5::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:OS2PR01MB1276;
X-Microsoft-Exchange-Diagnostics: 1;OS2PR01MB1276;3:X0p+Bp2OcsS0A4NRvS9FxQHaYHiB5tpF+vcqZoPDiaU4V8B1Rktn+Ti5vr95HLCzc+xzfcTcNXspUijfVM1ifqplV2YuGtlsnJPGkGFq1oxwFcwH9H7PjhWLtneJ8/0fI9d/h14B/g6u/vro3+CSkB+Vy64qsKlJ3LJ9Jj5As1Rm9LG5T6rVw2t1EMjrTxOTAnX7So4TTeyi4RlhMAq/onYFmeGyuu3GHTF2h9mS8Z4pJvfa5R085UT8YJgleLXN;25:mGyCmNkcYJAZm/IknfIrnAHLwW3feHlWq94qOJMjCUyJkE99GzrLdDsfbP8b+baGiNu33NoGKGhe+wU2QMb9KJZ8QVVBcKTsra1kRw7LGFsNU4UGVveLy0wKTUJU57athON9BTVZoIIztb2VPQS3ayy++NidEcs13NhpaD2FFy8NPxcZ3Mrzv1Az4760sD3pKr1FRG6Ofp9R+3eD4JGCnMIrfEJc1CHn/uzTXL8PENCKv8Scg74hT/M8wrYrZe8DrYvzNBQODxzvtwOHHBkziAdkiv1nnMKAHxlu51FO/rFBhzT7RQuQ3xhcYbScPLKRT3A9hLytRX0v5QCxgc9ZTQ==;31:iAtsEm/IKkk0EOlW4tjuXLxNc9nH55vSGQa206WS3ly4S10ipnRHnlqSF5nFpEyCIiA6EBKwYLmRdbNfhrKvTpfiG/HO8BH1Lyt8Nu/jTxboO/axh97zXcF0cnP82Z9FtWFO/b9NhzAOZhqFyRbzyomQXWAb6rzYQinVMHJ3jx/tP37ObiNTDa4UzSwwumWVAw9Xl/xs8bIHkEnwHg/BX/6jNcvQ5fZLoioNPI42sE0=
X-MS-TrafficTypeDiagnostic: OS2PR01MB1276:
X-Microsoft-Exchange-Diagnostics: 1;OS2PR01MB1276;20:3djY7P0vDzntmyaYrkm5geciShZsTfWZCQKOZKt4VnzA11k4UatlO5xdeR32woY5mXdJcEiN5QntSuCRGZ7+FdMyLpojHkCarfV1emtfecxAAGuIzDOS0XQsN+NLFP2eHoKe/n6I/G23g13aNo99OQjmlluUS4MiEUUpiSf/7Gln7M881v3Ai3+laWAD3tAbhT/QIb8rgE6t5OCbx6umi/UZrwbLwygAGYkTl5QD5v7A3adWC3ONvt1PTaCiM94l9SaDHjKjNs7J5YEj7iSUWljWs9BFCgo2TlWo3v7U2o+aXbxnQDnVNwO/mKjh/wJ9zYCDjwmLzw37tVdKeBrACINdnIWKGmsZO4BTJd6A+kjAxROBWmvp9BLjRM6cLGjCTJbtG2p6H5J7H4tbnTvcTlblSse835u6LWKhmI/u/rdWEJcoeCEN9I44Yr883/zFAALKBf9oXPWjkfRWtqIGv9REWHsp7CqT0v3F1NW58KZ6TE1W6PbxieUGI/1zYkry;4:aD33a/p6RHOGftw/FGtpflbNmaxQe8aOhN4JS+ag8nI0Z+Cfhlp3yPhuXMijIe3pnkWZv+1hQNUgZ07R6iu4MMJKoRP6NHqnwNyreqC/r7U7XAVC7l+l3F12ZiLYoCnGyyVjRHHezzbIKjzpinSVrhb8GuN6sZxJCvFzMM87PvJrJRrugi8XgjOv0e8Cd70C1LrRWjPYuUWQErFFxMPqziCFhLGBZQe4FZ/zY0qJUSmWdjh+oxcNcdGeIUu5JJCjDUvzuOHSzUye41tGjlzcwny6I6/L5dDDjioVET/afe6wExerwE/BVX4lOy6rn0WZ
X-Microsoft-Antispam-PRVS: <OS2PR01MB127678B5D403D4523CEC6BFAB2880@OS2PR01MB1276.jpnprd01.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:OS2PR01MB1276;BCL:0;PCL:0;RULEID:;SRVR:OS2PR01MB1276;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39830400003)(366004)(346002)(396003)(376002)(39380400002)(50944005)(189003)(199004)(5660300001)(7736002)(122856001)(305945005)(36756003)(74482002)(50226002)(53936002)(3846002)(1076002)(6116002)(4326008)(386003)(106356001)(105586002)(52116002)(23676004)(6862004)(7696005)(8936002)(59450400001)(81156014)(76176011)(476003)(8676002)(81166006)(478600001)(86362001)(66066001)(1857600001)(186003)(551934003)(50466002)(486006)(2616005)(426003)(11346002)(446003)(2870700001)(47776003)(69596002)(86152003)(54906003)(316002)(97736004)(68736007)(26005)(2906002)(6666003)(16060500001);DIR:OUT;SFP:1102;SCL:1;SRVR:OS2PR01MB1276;H:TKY-DS01.at.lc;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
Received-SPF: None (protection.outlook.com: allied-telesis.co.jp does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtPUzJQUjAxTUIxMjc2OzIzOnNKd0Mrc3lVeWhMeTBiVkNrSWh3VzRDNlNM?=
 =?utf-8?B?Yi9GNDlsYUVoRlVyY2ZDeWtFeGg2cGJuRDlnUnBjSUs0aGVFYWNXa2xYODRY?=
 =?utf-8?B?UHllM2FjOGlOUzJxTExyWjg0enRObzc5amZiZW4zUVcvTnlMaDU3QVVoQUNu?=
 =?utf-8?B?OWNCa0wzOElNTlVNWGJTWW9yNmI1ZHJQM0N1YVVHaWQzUHJacXBzNkdGNmEw?=
 =?utf-8?B?U2JlL1lndlltc0tZU0tXdStlMURxRXpHKy9odU5taEtDaG9pL0pucVh0bk14?=
 =?utf-8?B?cFdtMmhuZ0JUc1RPTVpmSUd1TnJYSFEvTDRLd2M2d01zYSt3RDZmN2JvNm1l?=
 =?utf-8?B?QWNvUmNlMzBKVXJ2dlI5WktLUWhTRkJjRmtCaW91VHlEYzF1eUNpUWQxS0pq?=
 =?utf-8?B?Y3lOcERVTVZ5VjhhcktLNk1Hc29zbG5JWlRtbFdnaHVxOHhLWGtCbUgzZzR6?=
 =?utf-8?B?Q2NKd1FCekY2WGptc3E3Y29PV3lHWWMyWlBGQXZJR2JFeml1cDAzRnBMU0d0?=
 =?utf-8?B?TEF3Y0FQM3hWd1FMeHJNQjFBQ3BvSHZENzV0TWhBZGRWSDVKbVFEV0thZEQ3?=
 =?utf-8?B?S052QzBnMVFpVFpVWmtPYk4wMkdwS0NEQ1RXcStQZldCK0JYUXZVNndPZFlL?=
 =?utf-8?B?TzlJbkJqdFRqbkllNHRBd0pJbi90MXhtblFmS0pxUXJpOElvU05YRlV1TXdD?=
 =?utf-8?B?QnY2MCtUL2Rid3VQOEN2Q2t3NE1BTG1MV1NqWUN2VTh6clBacnVJREVqOFht?=
 =?utf-8?B?ZllXbzgxQ1p5WmRBeXRDdUMxeGV6WENCSVYrUlRueE02QzBWZTZZR2pXQTZW?=
 =?utf-8?B?aVNaMExNdFZmbVhCQStuYTlnM2s4aGdvazYxeVc1UWFodUVYeUQzT3VkdlBH?=
 =?utf-8?B?QmdsNTZDcEkrSGZ1V2RsMHBlam52NzE4UXdLT2JQc1ZLUXpqUkhINktySUNT?=
 =?utf-8?B?SFdFbVJkTUVVT1ZsclMzT1dlejZVUVdkUnZIbC9QUnNXdXNvc08zWUtMUElR?=
 =?utf-8?B?QU15QXd1ZUhDT3h1eUFhRWgrRk8zaWZtTlh4MEVySnFacnFwMzZFOHJSUXFY?=
 =?utf-8?B?MitCTFBLSUtwWlJ2UTlRZDFJTVRkK2xmWWJJQnlQUjJtZmFTQUlzSmNjLzhn?=
 =?utf-8?B?elVrWDNJSjFaVi9UQm9TaEJ4N0NCR0JXd1k5em1Vd2FOd2E5Q0FvZThJa0di?=
 =?utf-8?B?QlBWR2FMQ0k3aGNBL0R1dGU4VEJhUXNNbnhCVVZvMVNLRnpla0Z4RnpRQk1v?=
 =?utf-8?B?dDJnVW1MY1FuNXJWV0xFRm5xcm9CajQ1V0M0Nlc2aDdxSjJzTm5FR2hkWHJZ?=
 =?utf-8?B?bEc4eU1iajYzcXljaW1PT3c2dkJOanNhbUo1U0dGWVQxNlpUQXl4MWhsSjRC?=
 =?utf-8?B?RDBLK2d6U3VOelBsVVNKejBURFd6ODhkT3AwbnJpazZNRHNlblNjZEFGbGMw?=
 =?utf-8?B?dFFIR3RoNFhEQmRQUGRmN2xaWWQvQUlqRzRCSnVmMTlKMEdxT21EQ29xNXJO?=
 =?utf-8?B?aEhqK2hMczE2cCtQYWFRSmM1a3NUZExjTGE1SXBKdFFLNnhycTVxMDRHRUxp?=
 =?utf-8?B?STJIdUpLdVY1Qkdobm9jblFZWm8wdVlZamF1SHFCeHM3VGRWK0dhT3ZyRENx?=
 =?utf-8?B?S3ZRbnFvbXM3M253cVUvSDgzRDBoUEhIOTBHWmU1bGxSMmhGQ0J5a2lmN28w?=
 =?utf-8?B?Wk1QNTROTmxVdU9RWEl4NnRLUkJXWUZnbVBkSjdVS3RYL1l2eFlYTWRpYmc1?=
 =?utf-8?B?QzUxYkNPME02cTZlV3NnYkRvRlkxMHJWWkd3dnZVdGd6TEpKME5HUUk4N0Fy?=
 =?utf-8?Q?5B9KFHc0aw72h?=
X-Microsoft-Antispam-Message-Info: NMKz/d7eC3lUFs29RvYefiXm1sa9wgmvTlcKNweIUhaX/0dhsWoUekikWoDI0RyCmD8NI0ffjdpOvJsBHIigvpOjjlw5fyJMshNy3TCyBmiA/4EU8sxKow4JEOWWUnJ9qRgxzTYgiXImBX4rtuaJnlf1bWLerUPZG1CzSHeh2CHDknH5MZVg99fzi/cHsIz6
X-Microsoft-Exchange-Diagnostics: 1;OS2PR01MB1276;6:B76IO/0P/rUfK3YUIaYgmmOrQlp3sz66oJWpNfTSEF7G22vGK6HzA0WqwWlSSuRR8pC7gyl3w47PsEK8f/mwo9TnPzS3ebF9Klkvz4S8o+lSSCSylTka5uFLWOs9vTSOBcqayXypaax+eQCcW0iat/ahcq2l2vh3xmeAwf+W54oCSjtuAIl1mimmdmEmITN2BhxqVF6mWiDT9hadzRAqi75J7tP8V4LaQJN//YSafF/ZzkSfDlvHIyA5H1nto87UuxKPaeqhW0u3/ufkcZIDmCi6ZPiTHeb9knWehu6CX/IFAQ//mLkOgNEktWXBphqqz0DBcN7l0gYI47HNx7qTayObP65xpD7eNQNWnfHrO+S4LgjGjNpRynZIUBw1GOjEPZ+4EAcO7iHX/jIoK0Ns4X+x9t0xyHp/oNp9nNB712myFqHDRRTVu59XcGrZz4F1CVZhRfU5JyxfdYpd1jxf1A==;5:BDn/SoPqLb2H/lBb7/LpqpPFxPosdZbvnRsiF5OdNPnc1KYM8xjIs51bvvacqTC1L7fv6IKOvIIanVsi1qA+Jdtz80qdJ2kKWlJJtOhBriT+yVNRU7ceImZj4x2qWNAiTHfePdidoxHrPMQo+7KznrNn1paIGIcPXl3T5bloQ84=;24:f18eI0HUBA6ECwGrsSg2nWc3s4BCyv7eitA4ini0fdqVCqCOTUd24xdkBTF8wDODV19pDk/BHvoubirB97faAeDFgebQASQOediYnzss8AA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;OS2PR01MB1276;7:0rTlr6KdDextf1NLB1l9kfQFafBjxEkT5xObXv6EYLgWQJLCw+nz2Lq3UA9PmPHYn9Bo0oKkDOGKcbiX8xXRSRjE9M6JCWxW5Jp6Fj6Lg7ISPgVQq0O/IxGrPf0BYZG05xMEydon40Oby3XOr54UP8Mu62GSNKTNZ/UfA/wxPeK0pHaPLZlhSH9PREh9jXSEpRTZS0ncQm31TJFlqdyFmOngzDQbRPkeEe7e9Ceh0i9X/id784A5FzmJ9OzQvz3/;20:mySqbOcqm4dteZVAdhLm3bsrd/qLOdPGaqJaGfx7CYROZR1DKbcazN9hfOY/b965azt4l301AaN/Jrb2/kb7MQYngygR6dduTaIsTNRWUbcw7gqra6AeaU+yIEjn3RMrm1KDqUP1MPiynoreXokxihduevDHZEzwA7JP+cyC9Pd/ls80qjnKZCaxtqkQhmREZh2ELcq4YKZj2fK6GMadmxGWoChDclK4wqDp7uZinu07+9GLsY7g9E7UlFVaNk3z
X-MS-Office365-Filtering-Correlation-Id: 05a0d65b-cf54-4ebd-280c-08d5aa199d60
X-OriginatorOrg: allied-telesis.co.jp
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 19:28:53.3709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a0d65b-cf54-4ebd-280c-08d5aa199d60
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1a8a37cf-9ecc-4cef-abb0-1ab01a15a6ad
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS2PR01MB1276
Return-Path: <smtpuser@allied-telesis.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: smtpuser@allied-telesis.co.jp
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

From: Tokunori Ikegami <ikegami@allied-telesis.co.jp>

The erratum and workaround are described by BCM5300X-ES300-RDS.pdf as below.

  R10: PCIe Transactions Periodically Fail

    Description: The BCM5300X PCIe does not maintain transaction ordering.
                 This may cause PCIe transaction failure.
    Fix Comment: Add a dummy PCIe configuration read after a PCIe
                 configuration write to ensure PCIe configuration access
                 ordering. Set ES bit of CP0 configu7 register to enable
                 sync function so that the sync instruction is functional.
    Resolution:  hndpci.c: extpci_write_config()
                 hndmips.c: si_mips_init()
                 mipsinc.h CONF7_ES

This is fixed by the CFE MIPS bcmsi chipset driver also for BCM47XX.
Also the dummy PCIe configuration read is already implemented in the Linux
BCMA driver.
Enable ExternalSync in Config7 when CONFIG_BCMA_DRIVER_PCI_HOSTMODE=y
too so that the sync instruction is externalised.

Signed-off-by: Tokunori Ikegami <ikegami@allied-telesis.co.jp>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Rafał Miłecki <zajec5@gmail.com>
Cc: linux-mips@linux-mips.org
---
I have just fixed your comments.
This patch will be sent by git-send-email.
Also for our company mail system the sender mail address is needed to be set as smtpuser <smtpuser@allied-telesis.co.jp>.
But do not reply to the email address smtpuser <smtpuser@allied-telesis.co.jp>.
Please reply to my email address if any comemnt or problem.
Sorry for inconvinient about this.

 arch/mips/include/asm/mipsregs.h |  3 +++
 arch/mips/kernel/cpu-probe.c     | 12 +++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 858752dac337..0f94acf60144 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -680,6 +680,8 @@
 #define MIPS_CONF7_WII		(_ULCAST_(1) << 31)
 
 #define MIPS_CONF7_RPS		(_ULCAST_(1) << 2)
+/* ExternalSync */
+#define MIPS_CONF7_ES		(_ULCAST_(1) << 8)
 
 #define MIPS_CONF7_IAR		(_ULCAST_(1) << 10)
 #define MIPS_CONF7_AR		(_ULCAST_(1) << 16)
@@ -2759,6 +2761,7 @@ __BUILD_SET_C0(status)
 __BUILD_SET_C0(cause)
 __BUILD_SET_C0(config)
 __BUILD_SET_C0(config5)
+__BUILD_SET_C0(config7)
 __BUILD_SET_C0(intcontrol)
 __BUILD_SET_C0(intctl)
 __BUILD_SET_C0(srsmap)
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index cf3fd549e16d..75039e89694f 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -427,8 +427,18 @@ static inline void check_errata(void)
 		 * making use of VPE1 will be responsable for that VPE.
 		 */
 		if ((c->processor_id & PRID_REV_MASK) <= PRID_REV_34K_V1_0_2)
-			write_c0_config7(read_c0_config7() | MIPS_CONF7_RPS);
+			set_c0_config7(MIPS_CONF7_RPS);
 		break;
+#ifdef CONFIG_BCMA_DRIVER_PCI_HOSTMODE
+	case CPU_74K:
+		/*
+		 * BCM47XX Erratum "R10: PCIe Transactions Periodically Fail"
+		 * Enable ExternalSync for sync instruction to take effect
+		 */
+		pr_info("ExternalSync has been enabled\n");
+		set_c0_config7(MIPS_CONF7_ES);
+		break;
+#endif
 	default:
 		break;
 	}
-- 
2.16.1
