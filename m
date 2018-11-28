Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Nov 2018 20:44:07 +0100 (CET)
Received: from mail-eopbgr780118.outbound.protection.outlook.com ([40.107.78.118]:56271
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992775AbeK1TmKembLF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Nov 2018 20:42:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNKE0acGmrUGf2vJMRfqT6GX4G7YWTzgWzCohvK/1eE=;
 b=h8Fgdyv7lvfz66iCKMseTMDfDwE91Hdxtav0oe3craLSSyl2Hk7fZPnNdPwPms74Skkdp8DfapVofsZiTLR5BQ0zNwfgnowuR5rSIb/hufC/rYWEdzOBQ+JZWn2QPpeCu1OPGUt4SeM1bBtGem+8xME3xvvo/h6qGATLkcO0fZA=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1165.namprd22.prod.outlook.com (10.174.168.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Wed, 28 Nov 2018 19:42:08 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985%3]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 19:42:07 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: [RFC] Migration from linux-mips.org to kernel.org
Thread-Topic: [RFC] Migration from linux-mips.org to kernel.org
Thread-Index: AQHUh1JyYgbm8WKxf0aPFFad2WolxQ==
Date:   Wed, 28 Nov 2018 19:42:07 +0000
Message-ID: <20181128194206.yhdp6247xobkj5cu@pburton-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR15CA0061.namprd15.prod.outlook.com
 (2603:10b6:301:4c::23) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1165;6:n6dlFiQ7DHvOOL9DsWOO+x5pPPe8DtGclREC1BxhSzBJjb/QkPxP7OvYlNYra11zOsu1W9roeu7Etcf/Nigc+XI6l06CRNMggfGUymXkQK6GFXUdHg44RpTCO1zipU4KUYWtxoF5zhloXzkTPCr+29H0KSmpuYGnpy1SEefxxW4Wm2jNt9TmmiIJ8y3ZYpW0bZ/+RHeGI1Y8IFodPLEW4Dv/Ll0keSWJY4JtiLUPEt2hJq3xrFlxZ7bah66CNQwh8CdCaR++g6idjCvObD0N3U8dA+uMXirgmfBreoUEaP5FJNmt6GBNDU3003+/LtOX1YYb6MT9K0QhhqczGguOB0z6EZKor3z9uXv6RLCc5xV1VWLJI5L/mW1e8RNBfa1RmqgU3Wa7o5/9TSzn7x6UeJBnyTfMdVbtbwk1Bzztd3Zl4mXe72Lw2KxPxcwnV0s/hhjJJEi/jrv/VJmSNq18dg==;5:Q3gIqbxXPyQoMETr3bKrbDGhX1qt5myb+oCrLCdvMrla4QKkanv8y6fgwb1Xox3VzziubZjZACrhuw4+eTpQgWlcdICCuQcc9EkAGqiK2kpeKLZS3G+wbtaNSCr27Tj3QkLMML+twJAycjv4ID4mPDmplzLrCc/Bvj1ji56fEaY=;7:fvKPMjJCyts0VsYWvDDd4xGrdF2wt1vpFk5ovO6SW8lJTW+ZeF+P3Ua7/YSKTvReNJAt4Mp4yJZQ0TvRrSu2UbXrDw1QFYMbVRc+DGppRUSH8vMgz7O3kTzcunrjST08dtV2hEA/3LIwx7Ae8YWTSA==
x-ms-office365-filtering-correlation-id: 3af36c28-20cc-4c2d-ee47-08d6556994ae
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1165;
x-ms-traffictypediagnostic: MWHPR2201MB1165:
x-microsoft-antispam-prvs: <MWHPR2201MB1165D0206274F2C27A4E6309C1D10@MWHPR2201MB1165.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231443)(999002)(944501410)(52105112)(93006095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1165;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1165;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(346002)(396003)(136003)(39850400004)(376002)(199004)(189003)(53754006)(305945005)(9686003)(6512007)(53936002)(14454004)(6436002)(3846002)(6116002)(1076002)(7736002)(6486002)(486006)(44832011)(6916009)(33716001)(99286004)(14444005)(256004)(316002)(58126008)(15974865002)(5660300001)(102836004)(2501003)(68736007)(66066001)(476003)(52116002)(42882007)(33896004)(6506007)(508600001)(25786009)(386003)(81156014)(2351001)(81166006)(106356001)(105586002)(26005)(2906002)(8676002)(71200400001)(186003)(71190400001)(97736004)(8936002)(5640700003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1165;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GoflLUuemVG+2Xkvndbe5rE2tb7b/nmIQ/z5K9FpUkcelXDTs75CbBSCIDpDT361Ixzwe9dwpt0rflb+PnruLYEv0QOYv6f0dzj25Al/CrXQGR/7FVPTaavmlUh0KMeyNkEdR3Ixu6apMNtcHqSH87083lRSgJqRkgcX2nlEvLuUmi+kDQWoGTlHQ87Pcdm9yHWUTw8N2pfq/3hDZCkvGV3X2DlDZA+Q08sGJCMUZEPGnQx7r1957KGjRfdgI86MUh11cHH29Ds8QQSL45+k+rKQtMt1fGH6jlqYd8w2nSf1/j37rofqsvsKd2MlQ2D8yCjV9xyvPHOCqmpb9vij6SPVG11u/nE7bOlC7d5VEnw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D97400AC6AE0DB40B1D6EC500F82E324@namprd22.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af36c28-20cc-4c2d-ee47-08d6556994ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 19:42:07.7673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1165
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67538
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

Hello all,

We've had a few issues with linux-mips.org recently:

  1) The SSL certificates have expired, and I don't have sufficient
     access to the machine to fix that. This isn't the first time this
     has happened.

  2) Recently a lot of people were mass-unsubscribed from the mailing
     list, which is not ideal. I have no idea why nor sufficient access
     to investigate.

  3) There have been periods of unexplained downtime.

  4) A lot of wiki content is outdated & actively harmful if people pay
     attention to it. Some of the key things like "which kernel should I
     use?" are much better addressed by existing content on kernel.org.

Ultimately, in my view linux-mips.org duplicates of a lot of
infrastructure which kernel.org could likely provide for us. It hasn't
been particularly reliable & Ralf hasn't been available to fix it.

Of the services used from linux-mips.org for kernel development:

  1) git.linux-mips.org is no longer where mips-next & mips-fixes are
     maintained - they have been hosted on kernel.org for a while now.
     As such the importance of git.linux-mips.org has diminished
     somewhat.

  2) patchwork.linux-mips.org could easily be replaced by any other
     patchwork installation, and kernel.org has one.

  3) The mailing list(s) are what I see as the biggest pain point, but
     we could migrate towards kernel.org infrastructure for this too.
     This may require me to monitor two lists for a while, but that's
     fine.

  4) www.linux-mips.org contains some useful information, but needs a
     lot of work to avoid providing harmful outdated information. I
     changed some content about obtaining the kernel to point to
     kernel.org pages which are better updated already, but I'm sure
     there's a lot of outdated information left.

So I'm considering asking for a linux-mips mailing list to be set up at
kernel.org, with content from linux-mips@linux-mips.org archived on
lore.kernel.org. MAINTAINERS would be updated to reference the new list,
and I'd monitor both lists for a while until submissions to the old one
taper off.

None of this would mean linux-mips.org will go away - I have no control
over that. It would simply mean that kernel development is no longer
reliant upon it, instead being based around the kernel.org
infrastructure which is well maintained and not our problem.

Before I ask for the new mailing list to be set up, I'm asking here
whether anyone has thoughts or objections?

Thanks,
    Paul
