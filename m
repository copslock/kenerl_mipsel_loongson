Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2018 23:12:11 +0100 (CET)
Received: from mail-eopbgr710121.outbound.protection.outlook.com ([40.107.71.121]:34367
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991346AbeKTWLRl3yc2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Nov 2018 23:11:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpML9Qi7D191KhVU21VAu9hk4iYu/NWd0DozTvyEHtk=;
 b=pAA+Efe2LPEzXQ/MIpbpuI9N9ad12kn26/j3ZJEQ1otKISflQnsxBqk6zE6BIDt0Vc1vMzY5XTFRe5GnJW2leDbR5pOPsOyJa6w2IwpYTZyBC11p2TBSN69gx6ZwmdXMa5BbbhvzDIKkLa4/6bfedolwNbQixEmNEy+mw68zBDY=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1534.namprd22.prod.outlook.com (10.174.170.159) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Tue, 20 Nov 2018 22:11:12 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105%6]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 22:11:12 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        "# 3 . 8+" <stable@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH V5 3/8] MIPS: Ensure pmd_present() returns false after
  pmd_mknotpresent()
Thread-Topic: [PATCH V5 3/8] MIPS: Ensure pmd_present() returns false after
  pmd_mknotpresent()
Thread-Index: AQHUgR3yL95WWMNyY0i4SyuqR5gY0A==
Date:   Tue, 20 Nov 2018 22:11:12 +0000
Message-ID: <MWHPR2201MB1277A8CB4488D38A4A2DE074C1D90@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <1542268439-4146-4-git-send-email-chenhc@lemote.com>
In-Reply-To: <1542268439-4146-4-git-send-email-chenhc@lemote.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR05CA0094.namprd05.prod.outlook.com
 (2603:10b6:104:1::20) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1534;6:BEgJviVjvymq4unBftPJVUZOAiAXR92YTBwmKewTo87IZ89vxhQzZ/+uzYlst9byOXc1N2/KbBZLTJjgY8BcELdbVLO4K7YT3UpIlj4ui+pzY9VphuCHCPPNrRbhEPmOVdtdlFH5GuEmHW6Jq3eK1zEbwgwCjWkaR2Y/v643dk7el02f/ftsJsc3aQOcKrVQR7aj9w7iIqj2huqDPn3JnQbPdRsK59rF+nGZfJcq80fw560oTh76QofwRNtW0mrp0qnpkx0KntfWi+/47hJeVwYhwNrAwLWXQwZOh6P8BXmf9iwzSTi0wdLf11yY1tRgzdPeunttne73YH5cAUSxYGTWV5Yvk/CW+N2Bfb5RJ/VqzBlA/vSAry5OlYfQUOtrb6+lPwEPVT2E07joZKc7ZKp+zKqVMpPIXxTGpH7Vs/+oaw5wAtfHMbnoRpjqbOkPsFs0meHgtY0o16jbQG+7Pg==;5:6oMmC3cMjChKvxqq8RpotPLiJcb7mvWGGrBV+bFp6gjJbUFmAll4Ra6mPvkg3lWMRBVAoeQiR4MwckNZBULXx6HpmeOgkpg07FsRt+CvGHhv38H9pnVyr3sp+isREMwGP0oXRocXgbpGJv9yp8U/mEjWARgjdBAHGdZoMSIqKDg=;7:BmBnbUc3GzmH2cNmHBlhvegJ41BaxoAxlaDnMUgY2nTRrNw915F9bPgIPt2+++vl0qz4h9uSqA47g0AUhTU7lR+LcZMdQHI2zHFCCo2A8WmNme2S8QdlHyEmpYDqHGwmaAKPVFFHoAqeCNAJJdwURg==
x-ms-office365-filtering-correlation-id: 916ba087-31e7-4d2a-0257-08d64f3514e1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1534;
x-ms-traffictypediagnostic: MWHPR2201MB1534:
x-microsoft-antispam-prvs: <MWHPR2201MB1534EB4B45B8A1FEA525F82EC1D90@MWHPR2201MB1534.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(3002001)(10201501046)(3231442)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(2016111802025)(20161123562045)(20161123564045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1534;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1534;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(376002)(136003)(366004)(396003)(346002)(189003)(199004)(54906003)(44832011)(476003)(42882007)(6246003)(71200400001)(71190400001)(386003)(8676002)(6506007)(14454004)(7736002)(53936002)(8936002)(186003)(11346002)(486006)(9686003)(55016002)(316002)(81156014)(81166006)(6916009)(446003)(229853002)(256004)(105586002)(106356001)(2900100001)(68736007)(508600001)(575784001)(3846002)(6116002)(6436002)(97736004)(5660300001)(33656002)(25786009)(66066001)(26005)(102836004)(305945005)(4326008)(39060400002)(76176011)(99286004)(7696005)(74316002)(52116002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1534;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: t8n2o+sRZhpzNFDYgM2r481FCWYkau+34+5TNu44OPg1otdpGHgMsawReaUphr4+3oq/9gNnW8NRuPzM56gQW8Nl4wesCGUbwBQfvapoLMDCdKybOrUXvAefWMxvn4aoPlFSmP9eBGRyl0jl4Uhu4hbzL3ny4T/fHdvQ3Lxsy59+zVU4vuprYM1gM31ZpfdO5JPDB1BaaDPi9WbKDMORNJi3/t+fqDyCr9MlMVIkNLhabQAiYljkqwO2YOd5KuYj3YBxUIg8BGYxs/xNpnlvSGlQKRpRHvXyTPnekRS4D8TsYz6+0GolY/gJNqp/n8AKGQbMY4b+2iKXlgXnHmceeG5OYVb23P58sSNFZRx4epI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916ba087-31e7-4d2a-0257-08d64f3514e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 22:11:12.5588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1534
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67411
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

Huacai Chen wrote:
> This patch is borrowed from ARM64 to ensure pmd_present() returns false
> after pmd_mknotpresent(). This is needed for THP.
> 
> Cc: <stable@vger.kernel.org> # 3.8+
> References: 5bb1cc0ff9a6 ("arm64: Ensure pmd_present() returns false after pmd_mknotpresent()")
> Reviewed-by: James Hogan <jhogan@kernel.org>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
