Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jul 2017 14:14:55 +0200 (CEST)
Received: from mail-eopbgr20065.outbound.protection.outlook.com ([40.107.2.65]:55353
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993955AbdGKMOsekM17 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Jul 2017 14:14:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sondrel.onmicrosoft.com; s=selector1-sondrel-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=akvEET+uuHOpAv4z3sXi+9yUsAtHYRT7GIlcAPQqizI=;
 b=vJibRXQB8p5fwBp8Q6R4FzO6XbvE/f2H0eUOVdKoIFECbwdmkqa6lnJRHvm3eIhrdoyk8+5FbLvOTkYuvwAkcs0lsiFmzAHUHT+qZPp6zfWhSZwEvny1NES9O8e/td3QaMcD0hEA9PNc91+S180A8WAd/joqNvrDp/a4YafZoRM=
Received: from DB6PR0601MB2534.eurprd06.prod.outlook.com (10.168.81.16) by
 DB6PR0601MB2536.eurprd06.prod.outlook.com (10.168.81.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1240.13; Tue, 11 Jul 2017 12:14:41 +0000
Received: from DB6PR0601MB2534.eurprd06.prod.outlook.com
 ([fe80::6de9:6f91:97f1:b042]) by DB6PR0601MB2534.eurprd06.prod.outlook.com
 ([fe80::6de9:6f91:97f1:b042%17]) with mapi id 15.01.1240.020; Tue, 11 Jul
 2017 12:14:41 +0000
From:   James Hartley <james.hartley@sondrel.com>
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        James Hartley <james.hartley@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: RE: [PATCH] MIPS: DTS: remove num-slots from Pistachio SoC
Thread-Topic: [PATCH] MIPS: DTS: remove num-slots from Pistachio SoC
Thread-Index: AQHS9V0Q0eL0AlEpo0OCwT39D7bKC6JOkz+g
Date:   Tue, 11 Jul 2017 12:14:41 +0000
Message-ID: <DB6PR0601MB25344ED6BED820ADDB025C46F9AE0@DB6PR0601MB2534.eurprd06.prod.outlook.com>
References: <1499238288-28914-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1499238288-28914-1-git-send-email-shawn.lin@rock-chips.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rock-chips.com; dkim=none (message not signed)
 header.d=none;rock-chips.com; dmarc=none action=none header.from=sondrel.com;
x-originating-ip: [195.88.9.101]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0601MB2536;7:Il+Md1cTBc6EKSYEDMaX3A8nJcWwMTWnBaCWDwTKIEwV/FgNIa5TfY3D+Dh6mH2R3McnZsdnmtE4y/za6dbARXuzCW9FCWsWAOoRRM/NWCsn8XLaqMnBfRLF2UwGWvKMvW/xYre5qKfgTIu/N2KyY7/rj4Ur+QIcu/uoxP+oUUYhK5/67rP2nF5HLijuR3gAiN+ODBvxnVDlC4LZBkXk0UQI02MQwBJJR4WQKwECIoiKkmkdl9lT6nSYQMfXkm3lkz/BOuXHQmYhio2u5g67BS3dCn/DsiCFe5rdvB2/jnOzxnGmg2W6t/hznSeO57bKys2dLWrPxLP37+1uXH+n3knN/xUD/1FNn0OIM02rhzwB+BYHmcsUDCl+6bctLicTn94ZimOd7CbDTDItbTKi2U08hm8u5Mu/bm15tOxGVuAy64Ole2ItOVNGzuSG2QKFoWxUgPrRttaN4ZHvZVUPXME8QqvGPeLpI64aPcj7Rgnz8WElEiujx1iINitcOe0/Qt9kKnbHC4FGCy4Qboeo1HJJOdN+1gVxjsDsQ6sxzwMGeQKKaz86X9HL86nk68fM/zzcZ5oWcgYQuQ+krn7kK62eg97xzYjx8Lck7rblSUg36opP+FGVHBd3UDtyWcWCvQNCiuiQmtFmxYm/5hhZRYQRCRl4eo6mFJoqMMKV3XPqkGwksVXqpKZBXtE5ZleF9wQRrE24uNxW46/kvC81CFpZ+M/qTIOqVJP/NaaA46BTOeCUBctIovJidHRXIqW5Ukx+u3ZuV32BHHOS9b/bUbl9w3qpO2l6m2q/GfjvhPE=
x-ms-office365-filtering-correlation-id: a4ca3c20-081d-4bd2-0932-08d4c85668d4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254075)(300000503095)(300135400095)(2017052603031)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:DB6PR0601MB2536;
x-ms-traffictypediagnostic: DB6PR0601MB2536:
x-microsoft-antispam-prvs: <DB6PR0601MB253658E3E09327D59F22DB80F9AE0@DB6PR0601MB2536.eurprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(236129657087228)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(2017060910075)(93006095)(93001095)(100000703101)(100105400095)(3002001)(10201501046)(6041248)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123558100)(20161123560025)(20161123564025)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DB6PR0601MB2536;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DB6PR0601MB2536;
x-forefront-prvs: 0365C0E14B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6009001)(39400400002)(39410400002)(39830400002)(39450400003)(13464003)(51914003)(54356999)(50986999)(14454004)(6246003)(7736002)(2950100002)(6116002)(3846002)(102836003)(5250100002)(25786009)(33656002)(5660300001)(2906002)(53546010)(6436002)(478600001)(38730400002)(6506006)(86362001)(305945005)(229853002)(76176999)(3660700001)(9686003)(55016002)(81166006)(8676002)(189998001)(2900100001)(74316002)(4326008)(66066001)(99286003)(7696004)(54906002)(8936002)(53936002)(3280700002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0601MB2536;H:DB6PR0601MB2534.eurprd06.prod.outlook.com;FPR:;SPF:None;MLV:sfv;LANG:en;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: sondrel.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2017 12:14:41.6961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4faa3872-698e-4896-80ec-148b916cb1ba
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0601MB2536
Return-Path: <james.hartley@sondrel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hartley@sondrel.com
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

Hi Shawn, 

> -----Original Message-----
> From: Shawn Lin [mailto:shawn.lin@rock-chips.com]
> Sent: 05 July 2017 08:05
> To: James Hartley; Ionela Voinescu
> Cc: Ralf Baechle; linux-mips@linux-mips.org; Shawn Lin; Jaehoon Chung
> Subject: [PATCH] MIPS: DTS: remove num-slots from Pistachio SoC
> 
> dwmmc driver deprecated num-slots and plan to get rid of it finally. Just
> move a step to cleanup it from DT.
> 
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: James Hartley <james.hartley@sondrel.com>

Thanks for the patch.

James.

> ---
> 
>  arch/mips/boot/dts/img/pistachio.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/mips/boot/dts/img/pistachio.dtsi
> b/arch/mips/boot/dts/img/pistachio.dtsi
> index 57809f6..f8d7e6f 100644
> --- a/arch/mips/boot/dts/img/pistachio.dtsi
> +++ b/arch/mips/boot/dts/img/pistachio.dtsi
> @@ -805,7 +805,6 @@
>  		pinctrl-0 = <&sdhost_pins>;
>  		pinctrl-names = "default";
>  		fifo-depth = <0x20>;
> -		num-slots = <1>;
>  		clock-frequency = <50000000>;
>  		bus-width = <8>;
>  		cap-mmc-highspeed;
> --
> 1.9.1
> 
