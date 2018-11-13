Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2018 23:23:04 +0100 (CET)
Received: from mail-eopbgr770108.outbound.protection.outlook.com ([40.107.77.108]:6166
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993135AbeKMWW0wNiUu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Nov 2018 23:22:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCpyFO4EV7U+Qfgx8kEI3oA0xgyg6rUYXhE+ce3ki9g=;
 b=bFpp7u3xHFLiOMqTlfhaMW29qtg+YGwpbnV0RD0cgZtvkXk/cJATRmee+4xY6tIiY7y3RPr+CzwDPgmGZEdOEITwH2GbSMvhBPMYta3e1g+UlDfYq4Xyw56UzT2pWnr2HE5J64caiCVAF8Z7lJ74WOiX/eDizcIZY79foQ22deQ=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.216.146) by
 CY4PR2201MB1350.namprd22.prod.outlook.com (10.171.210.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Tue, 13 Nov 2018 22:22:25 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23%9]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 22:22:25 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Don't dump Hi & Lo regs on >= MIPSr6
Thread-Topic: [PATCH] MIPS: Don't dump Hi & Lo regs on >= MIPSr6
Thread-Index: AQHUeGf/Q66CdebQjkWysLhfAhtVUKVOTeMA
Date:   Tue, 13 Nov 2018 22:22:25 +0000
Message-ID: <CY4PR2201MB1272806FC2CF07E48CB01210C1C20@CY4PR2201MB1272.namprd22.prod.outlook.com>
References: <20181109200817.23597-1-paul.burton@mips.com>
In-Reply-To: <20181109200817.23597-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR11CA0031.namprd11.prod.outlook.com
 (2603:10b6:300:115::17) To CY4PR2201MB1272.namprd22.prod.outlook.com
 (2603:10b6:910:61::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2201MB1350;6:uEr5o8oQkQCLFMk3GEOGSx9s2ejL0IYGmMO4TqF7rfGo0e8XhDc05QpmHGL3uWhmtBx2ym5m2lhgPq5riAKYZKQJ3tNPEBvEk55PvVo3zQtGWNj2a1B0Sikzfq/vnB16Ga6sDtvBdX+EVfBfhd5W7DiR8j52KxJ9b94umkRY28PP9ZgDVkrCgMoKmUz+v4cCKU6346FaJwPQD1pUC7GCx5dPUQml5lR0jnWs/ILBEacLlX6Ds4mMjNyA1aBMAMF11IUO4bzuvh6QLkI+xgm3DZAKlofdo3jBKdk+p6iwqbIEp4yd2prquGiLc1rpSQDpO0UdxViGOwFUC7ekV8Jw6WAV2G9XhKPt6OyOP0PVDAYmeq8T7+/VHS1DB18tJGuudQ0Z7/ezwctfUGAzZJd0hju84nqkilCoA7+VVnVIfEGG7OyfoRj1epdNNqoW7Pqnt7CEsPQccxhodDtRUDLNAA==;5:j0k8CeNWIgortIIQjza9MOXGRVCWE7f3pQfi54vJJ67rdS+wJvyVSD0ngFMLKSJc8SurJA3kb/t9ihzZXFWcUXKuBa/adqhG3S8zt/cLtRIHipTeZqsNb219OfAg3J/sABxqsBiUfDqWYYyTf7G6phmUt9MJAudJRzuus8EQit4=;7:S1LDMoY+LBxFOZDaxvwAoo6b3L55JUIlt9HQHE3KHrMh6cKfQ2eDsCRyduSJgxIhlsI8Fb3GR4ofUQUgun19E97Ha9J+NAjMASRIExtCf9R5dTLM+MadMwt9sVKc+88/KetD1loqVmrJW0uT357lXA==
x-ms-office365-filtering-correlation-id: 0ab691f1-9d34-405f-4aea-08d649b67d3a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1350;
x-ms-traffictypediagnostic: CY4PR2201MB1350:
x-microsoft-antispam-prvs: <CY4PR2201MB1350528625AA4220DE2FD5F4C1C20@CY4PR2201MB1350.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(3231382)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:CY4PR2201MB1350;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2201MB1350;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39840400004)(366004)(396003)(189003)(199004)(476003)(486006)(446003)(11346002)(42882007)(33656002)(2900100001)(97736004)(25786009)(6246003)(3846002)(6116002)(44832011)(54906003)(316002)(71200400001)(71190400001)(6506007)(102836004)(105586002)(66066001)(106356001)(6862004)(386003)(186003)(9686003)(7696005)(52116002)(76176011)(4326008)(478600001)(26005)(99286004)(14454004)(55016002)(5660300001)(7736002)(305945005)(81166006)(6436002)(8676002)(8936002)(74316002)(81156014)(68736007)(256004)(2906002)(229853002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1350;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iNj75Fq5WCRgxhp8xt4UYBFhHfNEoItwJmqQ6qaaEYLhZ8tVOp+6qO9BqmGnF53FGvFgrMCYLgdRFo9WINsEB++nrMjB0vZMl8b6U8g+sfBNaLs3xOl1BFKdz4zKeEoeDKhD14JQCJZDiOU6ToOqiUkUT4QVKyaIHN3KEIaBIv6EiYLmXwrLyj7EffuuUMGjDTbTENN3hY16CaAmh7ln12YTLouk9mJW/BjC+b+CYD1gYhcyeLabonCfYXgLtEkQ37YQJ4IGcDc15TBGMYxU3NXNieU+q9iJcPPuFfOE9SOm++bVUp5cfAF4irMNZb9AfZsVpIvsZjjjCn1YcSku8BHSrnkbEdUdw/S9x7H9yYc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab691f1-9d34-405f-4aea-08d649b67d3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 22:22:25.5224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1350
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67268
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

Hello,

Paul Burton wrote:
> MIPSr6 removed the Hi & Lo registers, so displaying their values on
> MIPSr6 systems is pointless. Avoid doing so.
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
