Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jun 2018 18:07:46 +0200 (CEST)
Received: from mail-sn1nam01on0124.outbound.protection.outlook.com ([104.47.32.124]:50000
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993060AbeF0QHhhnsb0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Jun 2018 18:07:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmXU9cGDmlauH90cJwNwpv8L20LZvwcZ/jWoq05anDA=;
 b=VkDiaJ/+Nc7t2Ne3v4+G7/sz3DnGz2+AkOvwZu1TCLgiCCMThaDMQJrKhCytke7TcmDHiUzJmkvxQLMLKwLDOBvm7X7eglUKA/ZoRxhIKFY8dWLr0a3Qxk+U3smhe477XsPiM9ZZLWWN5piyiGWY1Vw6JYdBUFAwEF2xjb8EgIM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 DM6PR08MB4939.namprd08.prod.outlook.com (2603:10b6:5:4b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.21; Wed, 27 Jun 2018 16:07:26 +0000
Date:   Wed, 27 Jun 2018 09:07:23 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     John Crispin <john@phrozen.org>, linux-spi@vger.kernel.org,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Applied "spi: ath79: drop pdata support" to the spi tree
Message-ID: <20180627160723.bhdiz5xmuuuz6fnr@pburton-laptop>
References: <20180625171823.4782-1-john@phrozen.org>
 <20180626145959.C26D7440070@finisterre.ee.mobilebroadband>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626145959.C26D7440070@finisterre.ee.mobilebroadband>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR2001CA0012.namprd20.prod.outlook.com
 (2603:10b6:4:16::22) To DM6PR08MB4939.namprd08.prod.outlook.com
 (2603:10b6:5:4b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec1cffeb-c525-4245-7a92-08d5dc481371
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4939;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;3:BHXfftkzJONNe99yTC1/amV4ed/bOjrquHbYlrY/7zaMxEy0muIfUOz1D1VFuM4MHDq6g2eODcpZiR6UTKP1bs1F45sr40+oje6xcbyqhuVVlqgL3CSZbmoFuUz6GZPZYLCURnv8qIrmCDv71ptzWZEIQcTnFZUUwS+eMJ+k2xurTu8wVt/W7etrkyD+zVOJGdS+tMhFJ2ezjsUepTQCJsor1F5f+ZV/jH8ZaYpGZHj1a3ckzrnj6OpOJBXl38+r;25:MdL/GMWv05Zi/VNAvyGeJ2n+z9L7dOTs/MhXqpJi9IoreFGu9iYdYqYnDZww2JCocTqPEPER/GHiRb611ETEIFM4HnZpC8792JrMwyBz5IrwXfYEm2S9tmcstg+rLmHAEolCXw6klCin96gFW82vHZDoPpcVRViDy/hcESKhy9zlgSkxkaur8nYvBDt5qma7kL/hJE1vbeCtKNhcZxVPFidcbVPRtIOzdPAh2buJqReZ+Fxb9dJ5nD4OvEFiosploXwpjIYM3QJqI0v4FyVqB9LI6tMobq3rLpe1mM78PfIJTxZX1MxTj8OMEmi7SQdIkjPj2JXy/ujg7fkcGYDDeQ==;31:uktDDKtVKuypfeCfYX669cRTilN7030jsNh7vMWX34r1ar+RyjoIW84aJe4t1lY/oICduTNCE6ndMNmDnr5/3iUzDqVUhWOhfqTRO1sp3ADj4hzN+PQS1uzJRSLfa43YCw2qu6o6LYorikqfSqqoMPPE11Xrn8oLmHX9iS8z9zURUc3nF6gMDfWWbL0EO3vzYyjHb1+ciHPVT3mb8ghRWCvKnCKA/AC+lvEOsrkm+Ho=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4939:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;20:N7OeRg8RVR3ysc6YqHgKpYlUTxeB8RWeGbcTdkvp3G1e7wqHP4ayq5fJ/n40EgAWSiFhlbwXOX2H8mG3oxfGQrSYWWkkuvN8ugvhXAXiPMjF9dwvcJPVcFNbhfjHvWu4ActrY4C3BIeImwxIMdRTK8KxQSRmMk0m8wAVUnB95P85E6/IrYxIeQWRnkf29HVaUpy67pdJz3V78m1Ddn0xdaqeoDQs5Vi2ed3OWjf2XeCCOrNTkQHgd87CcikzFdZc;4:ozo0kmdECBhY6/35gQW23eUky/P05QbaFCRCTgmhr7B+A11z/Yv9XMH+UsdOJqYWKTIQaEvJxx+4cp7wxmjuJkMSA5Pi3MCGWIUzPQpnj4nGnqvXGKQj1ZTXvkZMXGXi5+im1juGKCx45yjZAZcDOF4t7txXK/jrFQzD3nNBsk5vULXODoZ8f5qj0HGoez3Pu4vHVMLCZyDYuPieetPeYy7S9RjBlX7Si4RyCa3ONe0ZT73Qauj0Bx8zhg/loTORAvcyyGIGdCMUxiYh/mPUi5sd304ps9cKbXEA62X47B5zaFATipQ4jwy0+SEZHZV7
X-Microsoft-Antispam-PRVS: <DM6PR08MB49394EA16BBEA06CBAC34E8DC1480@DM6PR08MB4939.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(10201501046)(149027)(150027)(6041310)(20161123560045)(2016111802025)(20161123564045)(20161123562045)(20161123558120)(6072148)(6043046)(201708071742011)(7699016);SRVR:DM6PR08MB4939;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4939;
X-Forefront-PRVS: 0716E70AB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(136003)(396003)(366004)(376002)(39840400004)(346002)(199004)(189003)(956004)(5660300001)(53936002)(386003)(186003)(68736007)(44832011)(33716001)(16526019)(486006)(42882007)(76506005)(26005)(66066001)(11346002)(4326008)(6486002)(6496006)(229853002)(6666003)(52116002)(6916009)(446003)(6246003)(476003)(47776003)(33896004)(76176011)(8936002)(2906002)(105586002)(54906003)(50466002)(58126008)(966005)(8676002)(478600001)(316002)(25786009)(7736002)(6306002)(16586007)(305945005)(81156014)(1076002)(6116002)(81166006)(9686003)(3846002)(97736004)(106356001)(23726003)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4939;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4939;23:ZaKySIAdxGAJk/+Brgpqwdj2hVVXjqms62dZugXNh?=
 =?us-ascii?Q?ea+U2D10dZIjgW8WZd0KuhKtR0Z/kCz67tVF+INZZep05x64BU+hZpwc2X22?=
 =?us-ascii?Q?CAsm1ba8VhuaXhC/Hwbju+Rq0etfd+PP9YKNz/Casd3JmCVVp4knQ9COc4LC?=
 =?us-ascii?Q?7evLBpl1chvcv3n+LgNGWZmLfIAHDDkh1MoETB1MzLV8IF4OjBzkjjF3b3pB?=
 =?us-ascii?Q?CRL2gConalOzYzrpz1HAQqcGERqzk29Y3zRl0H3rQEa4+Cg+Ny6tZH1oVdUm?=
 =?us-ascii?Q?1XZ1i6M6+TXwvbJr3e4VryqzdgSw7hoeLbcPLlXkmQSNdZv0UI44iQ9WQIwr?=
 =?us-ascii?Q?5PliSgxnKKI0dPFfakZcqpQpegr+XeoiKpWKLKYC/x2q3/sM8ZFFUUG+jiUi?=
 =?us-ascii?Q?uw/SbYJ4nC9pr3cZ4Z050ULhyLpZlGLKbNHGLaWP+odrbplLvrjoHZKr6NRw?=
 =?us-ascii?Q?r4ObNX7jIUeBEWdtocMT5EUfPYGwqvfvQ/FAVcQNsNwclmpiqaKzES0J60oI?=
 =?us-ascii?Q?zD/tE4BWwWLJT/pf5t7yOZ5gFxcw4FT6Wizdt877yMZrMuIc9qmsk3gzBqve?=
 =?us-ascii?Q?3u16X2s3b74e9MbpWW2E6IB8IkdcZVzye3NXuYmn6dElUlHyNX4ip9xBsEse?=
 =?us-ascii?Q?hNuQf1uMmLeeMJ4WmcYAZ3hiJ3qaxhs1RGu9vN8bHg/F0tMyLTQkT92iptcc?=
 =?us-ascii?Q?P1MdS/veQzCfc0TfYxX6+OmWx3ZWgYs1LZniSCB+8NU7gyuhsKmpxHrz/tfy?=
 =?us-ascii?Q?q206XQGDrnvNwgrqZ0jPh6rQ+VspJL5yxBP/4qTuMCYwDhXjW6cMDzXH8Bnw?=
 =?us-ascii?Q?ee0cbcAb1qdBjv4ONNdoQz3c0uJvhdporLNhlSDArq9kXvRwTbINp4KKFXAC?=
 =?us-ascii?Q?/BKlwlkKnjym8sOTZH59yhf2foBVlWwTmYrN30TzbeJoI22TL2pf84FjUcpf?=
 =?us-ascii?Q?Z+cesLkkPN6wIyr4bI4m+zrclmFhnKudgmGC8uegiEH51OdJbFSXHcYUYZzf?=
 =?us-ascii?Q?B5CK3GHWgnRfaElTpwiApvgj9AthWRKAAdSMXUYy5LeDEtfh5bu01Eut7naL?=
 =?us-ascii?Q?4e/WFEKBZm3DjEQTgUOz5U68ymj51pFoUKYmocBt2Lg97lWXKsUdZ/0A9QbP?=
 =?us-ascii?Q?kgUNFw26EJnUAcBhXjZSuxrbeg8JTQKPuXBxOmDbvEI8zgzFyAgg3rk9LaHY?=
 =?us-ascii?Q?ThttPY90g8USK7R5GxnMTFy2FfJRqzuqac4E1HVXflNCOTyE3kPtMvSQmoLy?=
 =?us-ascii?Q?TVP4tk3LnhbSmRLrNI6+5cOC8+cKT6N49A5vEq7oBjURakAyPhmTKeo84hRU?=
 =?us-ascii?Q?uGQRfTM3PMolI0TrPPXu448jpxLuuVKp+rBsRLwpaQapp4xlwbV5GNMuG3HJ?=
 =?us-ascii?Q?65dKw=3D=3D?=
X-Microsoft-Antispam-Message-Info: q76YlyD6ZGhrsgmMuczY7IusK3M95SGBJqel/FNKvZCvvzpvGjNDxmEBkdTaX3UGwiMSOvbcEdaQLSI2MmUr3u6dG9scu6aRGZoMHPkGHJ30a31BKkDyNbrzdnI2Mf96ods/IzSFT/U1ddo6NY8iMeV2++JFJO1c/PtElj7ByaRHbSZTVkrK+GgVP+Y9JUj5Xj6cwPqn8sd50v3aOEWuApGoABhYlxcE+yhbYGeSyBi2Ki1636NvmH2Sr//nfEh8zzwITFuAr0C7UFrgEFGRAMQRwwBgUUnDPbNKpBXCKNMmXCWS86P9/K6ExIOLj6U2IY535+wbq9X7wEjsIPHwPKbGRQajYwoFQLc7pupPsXs=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;6:vfGV638wAO6gD/8VKQP6x+8zcz6PK0aQKydjl7DselynNwgXIqChJUmDyHD3nYzb5NU6qtxn7EZjqElBF3QdmmDcYwui9UL4kUeZWlLTlpmhpHciKPFWn8v9w6SLfFRQWhlgC7Oc/bY7nWdJAhTFFR/dEEOwIrmh6W3JXZXS5bHKwkHOkridA7g5pt8Sl+lnC1fveHb6GwZCccCUmt5RIn2RKNzK2XbexFa7cUsNcZEYa3hn9IEbM2twarmGnYL1gkgkegsTHNwULgeEtXDhg1sPwGkRRPOblqOFpkO28o/iH2wWFlVDFY72F2Gymuum8jGmsDsCBQToZ5u5YgUq1mROOiN5ib5Y2WnNimIh0nFIy5ooo0nIIj+J/+E+3KpFwqYURbNXIGGk+uEgystfl7Gs72RvUF1YA1X+xICXAK7CLNRAE40NJP+GOHpRy7/unkw7Jr7EQms1iLD/UC3+1Q==;5:ZKYqqczckMWl/kraxZ98fvQ0fOoe2HFz114ifoR3NbMTwwQwx3AvsZYEuxvhVBs2hWSs0XspzzMCDy0ph/+gLQjkQMAmG9/x2LIVaLN56y+Dh4sb6q6lHV8ybewPugCntTeNmGFkioaSpSOtuEjonx1Y9uYOcFQphtY70QWN2CU=;24:aRB40BD58VSl1eEhQdcKIhEOcmutUdUTjghiCB0Ay78IvUlWstoADhLMfwoxe7bLebfgIBkEeBtCMsBKt+HFMVJA91JwMJ6Zx4xnapacJhE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;7:tuXR9YP0QTsh8RVxe5gJI8fRoHjWhNLiGH4KZ/2jCTpmDnqUHmuvS1s4jDj0ufTwQ/RaKU4rwuiNJHJ11tAeTP66JeCq0c6s3H/fV3gLmK4PLgMcqjRHNfoFhmWymauduLJ+VaVIg/qOKLdipPii4utrBnNX7P0l//lokd+7qcbJbkERNPIf5atnUZEwOA2KwhSlhtENugyJaeE80CMqEJ8tWJABhjLbUc380B4RIk1Xgqf6A8UKPaUZEGlzo7Uh
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2018 16:07:26.2878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1cffeb-c525-4245-7a92-08d5dc481371
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4939
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64468
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

Hi Mark,

On Tue, Jun 26, 2018 at 03:59:59PM +0100, Mark Brown wrote:
> The patch
> 
>    spi: ath79: drop pdata support
> 
> has been applied to the spi tree at
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

This is going to be problematic if it goes in before the corresponding
conversion of the MIPS platform code to use device tree, which is
currently being reviewed.

To quote John's patch email:

> Hi Mark,
> Once Acked, this patch should ideally go upstream via the mips tree to
> avoid merge order conflicts with the series converting the target to
> OF.
>         John

Could you possibly drop this from your tree & ack it to go through the
MIPS tree along with the relevant platform/board changes?

Thanks,
    Paul
