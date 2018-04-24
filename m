Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Apr 2018 09:34:04 +0200 (CEST)
Received: from mail1.bemta8.messagelabs.com ([216.82.243.205]:33048 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992368AbeDXHd4ikRQ4 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Apr 2018 09:33:56 +0200
Received: from [216.82.241.100] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-13.bemta-8.messagelabs.com id 75/41-08494-3EDDEDA5; Tue, 24 Apr 2018 07:33:55 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSfUhTYRTG9957527h7LolHoeDXASlbtiHpBU
  U/RWlEUFUM8i7vG7Dfci9KyYLWlFpWimZ2ezDklxqLaUPnSkrpSAlV0pU1BLLRWkF0heime3u
  Tqv/nvf9Ped5z3k5JC6rjVKQjN3GsBbapIqaS6y4X86o370Z1Kb1D2oyhobKJBkVVack67ANw
  1MfiQ0PGz3YFkwrNlp0Vnuu2DDc+0pc6I6zjwSnJU70OLYUzSVlVAmC5uLTeCmaQwLlgM/NLW
  IeADWNoKW/XCy4KnFouBAIHwiqHIcb/ROYQM5gUOn2hOtl1BCCJq+W11FUOnS8nyR4PZ9aDS/
  6boY1Hrr3Vd+S8FpObQN/9a+IRwsvGl5KBK0B9wdXOJOgFoHPOxT2SKldMN7XhfEaUUqovHsQ
  EzLjYaCyLkqYgYIrnU8i88TByPBvseCvReAa3y/cJ8HtsmMRvxIGasuQMLOXgE8XiyUCUMNYV
  VUkqBVBRZta0MnQ03eWEPQaKO56H/EXwIm6KfGMp+RBDSaEunDoPHo1UpAI9aPtuADGCXj664
  q4Aqlr/plC0KlwqeNrRKeA+/InvCb8A7HQ4woSlxDRhBZzDLuPYdXLVmp0rFFvsJlpo0m9NC1
  DY2Y4jtYzJlrHafZYzTdRaFkOiETIiwLB7G6UQGKqOOny8kGtLEZnzSsy0JxhN7vXxHDdKJEk
  VSA9HAixWJbRM/Z8oym0cTMYyGjVfGnq6xCWcoW0mTPqBdSL1GTg6PHjuIywWC2MIl6axWdQv
  Mmw1zIbMbO3A0ipkEuRSCSSRRcyrNlo+5+PongSqeTSHD4l2mixzb40GmoCCzVRkhDgm7DRf5
  HCiXKWv3W0KarAt7BIeTBrx+uk9nMpWyfPKT1f1n6eWu96dE/um27Nq312gch1XpM//r7xTOm
  PJQWb/SB6G9M97I1h663X/Sm3CgLZmSefz/HfYX+erN8+Lzf9/Kpg41Prgq2HPMjhSM+cXOQk
  mtrG1qHObztj0MUjrk0S1UT+9xM6FcEZ6KXJOMvRfwC7hPv8sgMAAA==
X-Env-Sender: ikegami@allied-telesis.co.jp
X-Msg-Ref: server-9.tower-220.messagelabs.com!1524555233!204514607!1
X-Originating-IP: [52.192.143.101]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 3183 invoked from network); 24 Apr 2018 07:33:54 -0000
Received: from mo.allied-telesis-co-jp.hdemail.jp (HELO mo.allied-telesis-co-jp.hdemail.jp) (52.192.143.101)
  by server-9.tower-220.messagelabs.com with SMTP; 24 Apr 2018 07:33:54 -0000
Received: by mo.allied-telesis-co-jp.hdemail.jp (hde-mf-postfix, from userid 504)
        id 94A8E294002; Tue, 24 Apr 2018 16:33:53 +0900 (JST)
X-Received: from unknown (HELO mo.allied-telesis-co-jp.hdemail.jp) (127.0.0.1)
  by 0 with SMTP; 24 Apr 2018 16:33:53 +0900
X-Received: from mo.allied-telesis-co-jp.hdemail.jp (localhost.localdomain [127.0.0.1])
        by mo.allied-telesis-co-jp.hdemail.jp (hde-ma-postfix) with ESMTP id 48A371AC001;
        Tue, 24 Apr 2018 16:33:53 +0900 (JST)
        (envelope-from ikegami@allied-telesis.co.jp)
Received: from JPN01-TY1-obe.outbound.protection.outlook.com (mail-ty1jpn01lp0175.outbound.protection.outlook.com [23.103.139.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mo.allied-telesis-co-jp.hdemail.jp (hde-mf-postfix) with ESMTPS id 42171294001;
        Tue, 24 Apr 2018 16:33:53 +0900 (JST)
        (envelope-from ikegami@allied-telesis.co.jp)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atjp.onmicrosoft.com;
 s=selector1-alliedtelesis-co-jp01e;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=rhFmiG7xQJctEP0zvQ/6UkyW6VoVdUwa4jEfjYTxvKU=;
 b=DsGlHThYYP8Nw6uw8nkSOSUEyC8uuPFbjfBgDpyqSMnslhLwkI29kACqmdcdkcyPaxsX9SNwLRdxNch49VxFDwdHtCsuTjjCx/WDNpeFir/6AViY/NOQmiVdnbNqSXFUkpXZJTT8yYLWmNcE8C+wtOVHf8UKGRUP/3gAJOZvB6A=
Received: from TY1PR01MB0954.jpnprd01.prod.outlook.com (10.167.157.141) by
 TY1PR01MB0031.jpnprd01.prod.outlook.com (10.161.134.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.696.15; Tue, 24 Apr 2018 07:33:52 +0000
Received: from TY1PR01MB0954.jpnprd01.prod.outlook.com
 ([fe80::495f:2227:40ea:9f08]) by TY1PR01MB0954.jpnprd01.prod.outlook.com
 ([fe80::495f:2227:40ea:9f08%13]) with mapi id 15.20.0696.017; Tue, 24 Apr
 2018 07:33:51 +0000
From:   IKEGAMI Tokunori <ikegami@allied-telesis.co.jp>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     PACKHAM Chris <chris.packham@alliedtelesis.co.nz>
Subject: MIPS: BCM47XX: Enable MIPS32 74K Core ExternalSync for BCM47XX PCIe
 erratum
Thread-Topic: MIPS: BCM47XX: Enable MIPS32 74K Core ExternalSync for BCM47XX
 PCIe erratum
Thread-Index: AdPbnW6Ya94HI7S/R6SR34cQ5ieoeg==
Date:   Tue, 24 Apr 2018 07:33:51 +0000
Message-ID: <TY1PR01MB0954C80E15BA87D03E3A6880DC880@TY1PR01MB0954.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [61.215.194.29]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB0031;7:9F5gpYlDoK9BVyMHePnVq3z6pwHD/w+U59OLxnwsTGLLNiO5Woy3H0LtOKj4THQy1x4JdcfeSu18P8dUd3KOeH6flWgPOIm0BQQgBUWI0FZVTFkY5PTF3dBUdkhevBVy3GpBFibarluQa19oWI0tPiC8t0HY2beksw5bzQSphZrs0PVYJr37EpNg42+cZAc/c6VoHYbjXXkGc7xuGL57zJStH8OBZFknVkYBD9yEEBBbwkdGIpJpGk8sdtz7mw36;20:sFPNnQnD3adRUDZ9gAGEoKvRRBqyENoAfl9lLGWheERNpuY76gX7Drv7bMRTYxIteCleBl6YRBjCUUVA6CJ15miHYRZPN/CnHgYxLdfv4wGaCjpo5xmLgZxWad0hTJWH5Th/Rw/X1LrnflKs2M1bKr+dzbS86JMPqpkW2N6FfcuUwOkz4OMMNK2vI615Zn6ZotYHuSvKORnZ93etBMJtatFEqbFNb1K8AEv9j9iqbB3SoaHb0BwuRLw7OeAoPWX1
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB0031;
x-ms-traffictypediagnostic: TY1PR01MB0031:
x-ld-processed: 1a8a37cf-9ecc-4cef-abb0-1ab01a15a6ad,ExtAddr
x-microsoft-antispam-prvs: <TY1PR01MB003162C2C356374FF75F37BEDC880@TY1PR01MB0031.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231232)(944501410)(52105095)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:TY1PR01MB0031;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB0031;
x-forefront-prvs: 0652EA5565
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39850400004)(366004)(396003)(376002)(39380400002)(50944005)(55016002)(6116002)(186003)(476003)(3846002)(2501003)(3280700002)(59450400001)(478600001)(7696005)(102836004)(6506007)(53546011)(26005)(74316002)(9686003)(305945005)(5660300001)(25786009)(3660700001)(86362001)(4326008)(2351001)(575784001)(5250100002)(53936002)(2906002)(5640700003)(2900100001)(551934003)(8936002)(66066001)(33656002)(81166006)(8676002)(7736002)(74482002)(316002)(6436002)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB0031;H:TY1PR01MB0954.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: wVK+tw9+1IKqO55FgYEis3fbHPjoZgQryT+ItG7uDg9LPh1QGh/gaezHKZ0uEd6fvcTk838fCSnnWNhQGqWOB6LyDJ068lmxm7mWfsWd1+ayk0srqot3UIMBa1Zdf/No4szpVVXaQ01gGCZKNLaz7Mb1/H2akZv+5JuSnZ0a6PZ6XxfMCqjCQfr2PEuQOvIb
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 61f9ec46-fc4d-416a-e8cc-08d5a9b5b9b7
X-OriginatorOrg: allied-telesis.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f9ec46-fc4d-416a-e8cc-08d5a9b5b9b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2018 07:33:51.1868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1a8a37cf-9ecc-4cef-abb0-1ab01a15a6ad
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB0031
Return-Path: <ikegami@allied-telesis.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ikegami@allied-telesis.co.jp
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

Hi,

Let us consult to change MIPS BCM47XX to enable MIPS32 74K Core ExternalSync.
Can we change the MIPS BCM47XX driver like this?
If any comment or concern please let us know.
