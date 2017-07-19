Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jul 2017 21:11:50 +0200 (CEST)
Received: from mail-bl2nam02on0057.outbound.protection.outlook.com ([104.47.38.57]:27520
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993892AbdGSTJy1BXoC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Jul 2017 21:09:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MsU2Wsm3VGA+wLWvmtS5afE+FByvKFmZY2/M/2LN2Go=;
 b=jrUzloUWGpQVdGibL0eaO01iZkqu090lxdkDrHDZD0OzwHIMcjg0xnZxU7auwJpcHUsrT1SUT/FgOTu91NLglExp3NxumhgUKVPtRSUJ/oVP9WQZo/1t+2I3nhsPsp35wuYtC+8cj3l5OPY8HulZr3f9mR/ZoiUMjYOTeOECMHk=
Authentication-Results: linux-mips.org; dkim=none (message not signed)
 header.d=none;linux-mips.org; dmarc=none action=none header.from=cavium.com;
Received: from black.inter.net (173.18.42.219) by
 BY1PR0701MB1224.namprd07.prod.outlook.com (10.160.105.155) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1261.13; Wed, 19
 Jul 2017 19:09:46 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, stable@vger.kernel.org
Subject: [PATCH v2] MIPS: Octeon: Fix broken EDAC driver.
Date:   Wed, 19 Jul 2017 14:06:41 -0500
Message-Id: <1500491201-32520-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: DM5PR07CA0036.namprd07.prod.outlook.com (10.168.109.22) To
 BY1PR0701MB1224.namprd07.prod.outlook.com (10.160.105.155)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e20cfb4-318d-4a2d-e978-08d4ced9b912
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(300000503095)(300135400095)(201703131423075)(201703031133081)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:BY1PR0701MB1224;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1224;3:0A8obNTWKLCsmxK/iabclMFmkkz/GdiAnwNsG0nMM+xZVt671vhRXPrdQgeW7/T8IHrq/d2JHu34GXbPfV6Ax+9TI91WJsW18d+/cu7CNBDHR2TF8I3By5hlrj7+0ZTUWE1A4j6EWQ/dJn7Cd+GGsgTL8BeywmkqAqY2bvElj/Rt8JeDV2EXWdFXhwuPBrRQ+95Ov7SjfadAq3PLnrrrkMyMxkrKJQlcShNLyaHPWZrFURVB6Vhgnh33iH/AoDHGcpp1okqVh9hOJZU6h/yUNanFXThGuJE0fnFHd+Ry8URSFSVQq6QYstO2TlK98SmDulX4G6VIlSPJVyk16td0/rnEt8bSf6uxfnzdVyUb/6XnyyaENBzGfEoZwDASXY3mfrm5RTO6gRDXE7FnZCXIkkZPYUkOp3yql+nTe8IklkaP2U5FN2OH+1gV5V3fZocZp9skBs+EAxcp9ow6WmFXJaH2/K4X2dZ07Xt/lFutENK0Sban3CIaQkyLyNoWluznLmnmo1xCtlZvuhzb3chtQfutSs/98++PfprhUci8fhLs7MT7NF0IGetGJUQl+PPVcLIoA6rR0cRDiVqMptdARPZZJ+atCxqVrKgvXFh2x8C8mDmNR3XUUvNE+nKeiab87Lfdd+oAJLsAAgq3jW7D1moEFCNgNk+Hmz49NwNrkA4JJY/9uG9ZyAjs4UJyUfm/wm4X1bauVrztpytL9bAw+mL5e57K2gcw1sGU7+zDngs=
X-MS-TrafficTypeDiagnostic: BY1PR0701MB1224:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1224;25:hETIDQhdoWZ/SS8s4Rdns6+VsRPnp1YZq/7W0aYm0YvhbXlN0QCDCluI40ogQG4jxnlhD+8KgETrO6wEyfejOrMDzxff8Djw3Qy44G9QYDaBPsppmhUaTiOAxB325KSb5/q5ttAc5xAQrqnya7QyiJcVgpm4decodtdRfre8MX6Vt9tG6gzCugFUEZnctlx21SN2gv/CR7feoS394gKjYf8Gg1/p8ZzE5je08mpiB2u1OYkFdaHTiIwZzX8J4PUGQe+Ct0eDnVV0m8Q9PkOmsqCjmeZZRnIWvyokx9PVhZ9cFcU8hLAXaMjQXV3iQWFmueCXjvU9+67Zq+Mby0Sj0O5N4vhhwtom5Q+y/2EXQdF6l/NKRsg91LJ7rSLsqER6vlctnITHRVo1HcPHm5i0qfojC6Tds9Vg125Oo5rxqzmWO9F5iQEMnB1bHI5CdrCmZM6QuupcSvQpeNapK87MqeTW/bZR2YdCdD2TKWB6a7dOsxXcFSm5UyLvBROCNhWVtZCML1nq5b/dEj1eQHO75VgviyWLQVIXrMJMItIQqQETWQvSSuEKvB5DF3nblfW24eBWJot7FJi1ePiQuJZ3bazHOgen06jPZ+YFO8VbJyD+h95f5RQAx0eLs4ZB5oz/yW7erpzenhIT0hW+VKpy6/R0AZixRn2GR2k+XfTLc2+hi8Nmul8XHQRmfSNOOaAOoT4vz4wMjgBefOqkzoVmNjXyWUSoGWT9UZvCLlJO167NmutvJUp9pmoVn+k3OoU1f4s+iZXnAtTF6WF/rBbkokYzkyM/e52Vz2qvR1OBXWlcZVZFoYnW8cHZx7IqQ9zb55B9jJppfZzymLQDseEkm6uignNLFD229ac5ub69sZZVJ2Dpc3it7NwAf868H7R1rMX+fgObsYzwbcZY22Jwn5ikqSFSC78hAdgAEPR0X1w=
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1224;31:FdZGyrFffdd02LLSIV6iQ1+FzZxVCALhzjlh2qi/QtbK+EnNwpiFUkOEAvf4Fw7LQXwNMNhebkqfeh/01PjAY3Ua2Xp5Y7Ae1R+fPCGFShQCgwLOZ5VVLSD9h3xiPHVAnOWwIXTs9bVGHFBRlUc9CImDAOpw2Mr66rdgY+R9zvzyXN6gxazcnq3v2BhVKwkHiFL/gmvHoJH13D94xYfK8jMhgh9I0VuJHqvQf1os71/bX+SzYNs3Io+1oLbTxU0z3MCyZYSp0N/sa1cTSzuNi3eJV4PTgeZuDDorAX6PO2ar2hRcB34xwngIDOyhf2XRQl8Akm5c1UM3jSQP0NbQCG2VnFR040tjynFwWpazyQN8IuXa4RNVkaPZsTZYZuVqLGoVjl1fojOwV9uAEmXGH9W3PGsCTfdlaYpwkGQvKqGP+w0dAFn3RRZ+8x2fMXOWd9knEcvuhqtTPlP8AbXSkExzJu3GP7/kzRYZywzIZDwizJDrHugDnlQ79mulzgi86lC9/zaNX/sCjqLM5mbBCNVOJmSTx00q0N3m65i13qbYvs7djlu6y/y10Jof7WUS4S+jkQyVjaPR9K8+cP8La6PmyZMr6ZAaxJksXexUvqph/fujGFHGlYTpTuh2kRePZW/Uqu12rQGocy4DPi/jivrYBmGOm1B5qO8UONKro+PQWMdprPesvMrjA1ciRi/9
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1224;20:/i0lvksX2R17Q7ugUVh1WiJ5Cq9khAuO+BldTB/eHAQTGG1X9dgA/ZazdtSirN3+tKtP2AiR5Jb3hWPjjUwX4/8vdrlbdUxmoPUEzv+RuAgI9aby6C3Oibmrwgu+WHXN25G1d8In6nTV+La7s1mUW4awgAkWpX3fnZuE3Sh9dRRDqZgl8wTUnlWvDz82aZKBpZ/hw7UJJnNcyJfq7+RO6Z5h77HvTgqOX7kUAlWsLpdP+hMPACc5MNA8so0soOEFVbtl52IALZ23NHQkh8QdxRSubuTCOuTlc0qbcuGM9WgSWciR3kuMi5HtU9ckcwPkcMJfGw81x8cHA+x+J9SrNWDJy1yBWi5J7nO3HEtfbKh+qeXnD/g3uZZpEfkV3vuz6OWUeeepuvwjsANk24HfEDRBEVRYfmRGzo1+xrlkjp506C5cfeMYw8Td0WffxUKv0NE+bTunBkPBPepTBDZxQsu4AEQu5KmY2ON+cnJo0hOG937vgRD1dEWkEGjHbItS
X-Exchange-Antispam-Report-Test: UriScan:(250305191791016)(22074186197030)(236129657087228)(148574349560750);
X-Microsoft-Antispam-PRVS: <BY1PR0701MB1224FE21B7A39A2F73FCE28780A60@BY1PR0701MB1224.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(2017060910075)(3002001)(10201501046)(93006095)(93001095)(100000703101)(100105400095)(6041248)(20161123555025)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(20161123560025)(20161123562025)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BY1PR0701MB1224;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BY1PR0701MB1224;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR0701MB1224;4:Y8jWbAmwUmnm8rnlGgbB2eOWNRSRydjX0dKJOSLV?=
 =?us-ascii?Q?WOsxqi/PIs0mNpVrad6ToaLHteaqHa54RvcUphVWe2f/t5zWwk768YLsHH0m?=
 =?us-ascii?Q?w/gUshbJee6Z6UU6ADPpt03n0BxeGrMgD7YrslXyCWU0Gh34WUa5jOmSqVGD?=
 =?us-ascii?Q?DXsaVr49k5c/Ht8VwcxUr/4hLw8BnJIz0XBEZcY2loFWtv2Nc2HrZwgjmDKl?=
 =?us-ascii?Q?XrQVQiJ3BQBI6gYwDDydDI87k34c6Ud62iEJlOmPN9scU2E0Xg2HGfVZklDO?=
 =?us-ascii?Q?cC+Zz4sYZiCdaXKf2/ryVCexcmT7Jh19iO1SaWrWJwNkeF+ldA0wdIQXzxlI?=
 =?us-ascii?Q?0tmCYraUQNviiWrPW3n3NImIR/n5NY1E2czAU9Jw+Zxsh2ZWGpHyO25GlNAm?=
 =?us-ascii?Q?Jr4lEPb2CNPehRbMrOmjioBiaDhZX+DQj3amn22Nnt42o9A4kEGXwdM6o8D9?=
 =?us-ascii?Q?OqCoyrnaIXqtiFx2avavCqFqJtvXU7CLqh+iFpLDmuRmPytDdEutJB6DpNDO?=
 =?us-ascii?Q?mUkERG0CkokhTjlxVsZ18IDMNkg6uCH3QWcw7mGN5cu9aa6DmpAeX5T06wtv?=
 =?us-ascii?Q?lTUIsUEHABwK3JZEzDsAJzAhh0J5s/S6AXHvPgVMgzK+HSoBBN1/1wETBu/y?=
 =?us-ascii?Q?ev9TryaacoZJP6I8EBZwedGYEFx9MywvgCFq7o/MEs4pGvqPmlteslvJwl7l?=
 =?us-ascii?Q?Iy0JVHUH2aWCEe8GbgrMtvtHg5lSsQm6qOpeDC92TPBuhMB0iKHEEVrWwula?=
 =?us-ascii?Q?XHC9Xsd4UwtyZ42+IbFOqVLm7kehPQC+zR6lFYcfEPbp9VKWj7j9q3sWZ1eo?=
 =?us-ascii?Q?S3CT5nNla4znuWKyzpDh1i6L6r6ycKQ/BZkE0libxbjBtQQ6lzg1WSsUdCI/?=
 =?us-ascii?Q?HvkCrqgq67DmpaAJJWKaFCdtauvB/rk0YbHwG3Z6OzWcyS9cIWQnK0k2UNQm?=
 =?us-ascii?Q?48Cflzkbp9oOZ7uMZGyVbbTo6sRIGcVLu+4cArA6EaybDPPI8NJEA4nawSUP?=
 =?us-ascii?Q?o2ySgwdsevZvfnnybeBXJsbhwOvIly2AyU2eCmyaU1LjQltOmTd5j1MIfAL+?=
 =?us-ascii?Q?uRZPkEqD8Lq9qg0rRb13KZp05vBrrMJfv/TiaZYWvIWr1Y7JBuj2KPEooFHz?=
 =?us-ascii?Q?7Sa8d5xgCEXFlCChb/iZyu0z3my8vtPrDTYhCl/672HlfgzC4nXleHAG1laM?=
 =?us-ascii?Q?x6SvXGdPLxUhp2bLxgqF/F1v9w9gXSTm5F9St1yYr70MJnkJrCCmDA05ubUQ?=
 =?us-ascii?Q?RvhdzCy7biFKsqznEX0P1xO2ZOkPXi/xF7Yj/PcSh8jWvMtZCCfA81DRgHyb?=
 =?us-ascii?Q?MphknBCugw9HV2Eh8QFwivuC5ry2lsZb/AXzdBtcJaUH?=
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(7370300001)(4630300001)(6009001)(39410400002)(39450400003)(39860400002)(39850400002)(39840400002)(39400400002)(50226002)(6486002)(53936002)(4326008)(8676002)(25786009)(7350300001)(50466002)(47776003)(2351001)(50986999)(53416004)(110136004)(42186005)(2361001)(6666003)(6916009)(38730400002)(48376002)(33646002)(2906002)(5003940100001)(3846002)(966005)(36756003)(189998001)(305945005)(6116002)(66066001)(72206003)(6512007)(7736002)(6306002)(86362001)(575784001)(6506006)(81166006)(5660300001)(478600001)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0701MB1224;H:black.inter.net;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR0701MB1224;23:6YNnaY8Txeb0zVp55fGnuyzQoTeeMMshKmtyNIO?=
 =?us-ascii?Q?m1d6/fGNmUlCqdAtMEXTp7QFnEH0AaP6mflCz1oEJZFFzH9wZdF90mwQftIw?=
 =?us-ascii?Q?SuG7pg9lCYXaPKCjAG8fw8MP0ogOS9UXZ+wds2D6HmxkksCilFtcTFLR39EP?=
 =?us-ascii?Q?hUiHQ7TUQ3zujSDz2RrNCttrC21q/kzRGNmFRdgWTu6vabg0MlbJbWqWSR9n?=
 =?us-ascii?Q?e6SGX2Rk4Jc/UytlNVCWXC8n7pO7mOYyYe4ItBfZLijeuWaf6VwqA8p4HA0u?=
 =?us-ascii?Q?SiGVmjhVNoac5JYn2214KwpCRFoMYY33wBqantpzOuUUgnycB9fDsVWYB7ZH?=
 =?us-ascii?Q?g8VYMNrHWQ5yEEFlRfdicdkSugJyX9GbmAoryxn7sMMdcXx5VGApdgAW63fo?=
 =?us-ascii?Q?lYPmbWSrs6ZD2Bk8IqyBfQjQZzyWWJHbLZAO2r8UW5EYR7sulfyvIl38E9sb?=
 =?us-ascii?Q?V2NIKMmRwR7/zSlks3Z7Cz95kGtRTK2Z/1VBq3mXFAz4OPw2OxL5WJg4Xrup?=
 =?us-ascii?Q?dVti6r4aX6XwQyacCqWgACJ+7gyj2l9L8DMVpxadpTH+XvDgO6SMTco1OtYi?=
 =?us-ascii?Q?cS96O+9E9isFOXHv1m+FuR4LYuW4n5yHkYvE1aOQS1LX8XyVayfUS8NUG3Ov?=
 =?us-ascii?Q?nt1tqtPNK0oPp8BsEn+9fZsVE++tD1tFTBFbyjtJQOWhNHoqogxCdPVDkXfi?=
 =?us-ascii?Q?IRSRWzobta7uXq+wwepZ3cfKilgFf1+bN1q+INlCmsu7Jr4iZkPxal7Bcerh?=
 =?us-ascii?Q?AMxTajNgEUN/a8xhtZnnY9TcdOSij4z4+2150tC14DAFe5EjEuUZ5XygmOKa?=
 =?us-ascii?Q?q+sk3CBaZd3bgTn1Jj4BjyRTSyQCqO4MOoOVV9NFRLEayP4kCRmn7iezOd1K?=
 =?us-ascii?Q?w2UWOOM36QXMVb7C7yti2sEjuhxW7bLYhqTx1SrUyib0pwM8LL9Lgj0DJEbp?=
 =?us-ascii?Q?LWds2PXAr4mS2f3AAwM9xUgWeiQB57TOt9+kanSWaOXVaV/54jlds7qx9o5T?=
 =?us-ascii?Q?snSk4EKQ1SqukFpmxk5CfHgfo89k/kc9DZRnwn3Ia4KIkZnEzujrI0I3kgi9?=
 =?us-ascii?Q?kwfy2SP901PEaijpN/3eY+Ac2Z2bGbPG6K88zc+8HDgC9G5ZIYCrGOQ2iH5I?=
 =?us-ascii?Q?Tbjum1pZd/dbyMNktUfBbrQ6V8AdKHvkKjXoxZ+DrAPuOHYb1HpR8tngkKbq?=
 =?us-ascii?Q?H4GT0MS/fjSmjQMEqiDphlvRH+KFBj+GLuU/jvwFFl8SReUtEkVnM6I0OSA?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR0701MB1224;6:pLQXNPD/SJQfSd49lEZzI8gS574LKE8ruDtD7iWQ?=
 =?us-ascii?Q?Bm/MNnYR8Eer1n6heREsREOcQrMyIc1w1+qC2XlhA54ih/th8j71Aq7/6e5V?=
 =?us-ascii?Q?hFRbe7DDdX5DL99iIDz2O7XuoPeQ1QjgGyvFbHfgmsSsmgLL1HdZ+rAd2Nkm?=
 =?us-ascii?Q?fzs/mboT4gSa+ajBfM0o9TuLahjy7LhhsAnNN+S9IPIGZIe++F0a6oN2+so+?=
 =?us-ascii?Q?6YiYv3oZpYaFjO3KjqLBSqSn+ICLxVvUnVDAVVuNl/BWomhBwKafMgLeVZe3?=
 =?us-ascii?Q?rLo5qYATIxGoSJDOVC/GEVCYz8EEjFdcqqDwZufWygZz+QjUiLNDkVD9MC8C?=
 =?us-ascii?Q?nNQoe9LI8CZk8tDz5APi/gpA7VMRfsECImu48NtV+LKRtOtYY6EumvuTl7nv?=
 =?us-ascii?Q?aFU9Dheww0Msh1/T9sN1mzMeAdhtSvck7eTq2ZSEbqjjRaHT6LWw1kDrVnFM?=
 =?us-ascii?Q?SEWHso8pX0uBuLP8OfqgcpC3TqUnc2IDFB2B88CzDsLM2x/SR824q/7WKCZR?=
 =?us-ascii?Q?prz7a/IH5kbX3BY572Bga4vFFVqArq9yu0FJEOMhUA+QpNmfbM9j2pFP1+Sv?=
 =?us-ascii?Q?RDVw14kQQMHDrDTv4Epftabl12SYGaq+fUmJBLU2V9YJ9nWoMLqWwKF0Hbov?=
 =?us-ascii?Q?qj8e61QpG3XsWazN0Yn7efyBhFsDQb8zUkhWArD1g7TDG3ao/e+PRtCfbJul?=
 =?us-ascii?Q?hVC7clhOC/oospA6WMutQxOnQgjIzZZIsCNTU3jp0L2xiXTaLNqczf326QZF?=
 =?us-ascii?Q?sRYbcHJw7Z9VyDJ5hc8h7cA6AIa6U62qnYdttt9j8j9mhc/zDpg9k8dwmpyg?=
 =?us-ascii?Q?7g/VG56Nkcrwa3DD7Q4cOeUyq6sWIb5Sjtxx45g1Fs9XswCM4vAR6nLtOjwc?=
 =?us-ascii?Q?7HLnWsrYIy4DgfJClVLla4SlD7P3Tq7QH37oo4PG2WIVRyuB5HOkSCdSXHNJ?=
 =?us-ascii?Q?6qHswaXTgQVq3jo3ygJwaBTayV7vRutw4008krjmU/c2LTIPK44qe9ow/h8h?=
 =?us-ascii?Q?qk0=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1224;5:LNgMeVe6QeVcJo10sHKYefPhhkcTYjumJTc7tz7A4NpWJqJAqaPSvJYW6h0RM7nY23PiUuF4K0iilpGJTIQqgDviGqj0KELUaYkIE5cZYdTny5Fj5R93YP2BhrSd7ReRtZp7WgWGLWR/QQNI5LcnE9twDFuP+nnKweQkE5mRMMLUA1il6Zk2zpdvPXGsEGpdV2STzUP9byvSCnJ/0yWFNOm5zsojNYLSB67sC3Pk0WftPyz7YF5oBNxgJTwVerz9mb53stnLuU3u5lPCusT8BGNYxXs7KEyq1BdIoN1dQUCXjrrYziv7wQRuZL9SBt3AWrrHyr6K92rM3FEpQCwYFyLiB1YZWXXsF6tCD/3p/I7jLixS4v7ZB4ig+MVAbX8Jzt4UxGf5bv0CkDgJaSEwdvBfEX7LX+CAA8dR9wuC6kDBnDCiYZjYu5zv2goerueH9iWRt6BQDFXHdojYcGztpMSNy5WDdHyG3Hpl7X9IfOzIuS94GzJepxDMJlA9bvy0;24:CzDORrlGfZDbF7txh46pSQnrmd+oC3ydH5pC3Rz29ErUohHXQsAXwl2TOaU3RvQtX0dJ9bvWODdNttqHtBHvX0tXVPN9imUas4mlCOGC3xE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1224;7:u6ukYvQBNWc/jxA73b+RUQCO2umHcwauSnJNbyeDGjUqBl+tgMKFLChQrz/RjydwK4rOybHMnQ3l95sgT3nAY+3IXk0z4Z9nNl4s+SUByyg6L0zQF7wvNrSqOmhIe1EbEsy9c1t6s/tkaTJOvACKx91/3EIhhkIQBA9uK6+F16UBZ3iAWJENPETR4rg8OQUvEtA7gPpcWluc/kimoka25ib/kXO6wSYX/gkZ1x8Vr6GNebcJi5GBVRzrvOL+3K4fi8kB2U9pYPyOQKTwbjZFhxH+HfNobnaszs0Pyy717S3iNDKRON9ZBqmyOM0oDJf/6H8GBW8E4qA/Jj4oAa9H1Vk6l1Wo+YTP/hXZLXpGEMz4oAE2jdcZ5SV/9ctggeMQLuybe91ErBkFsHJOywCvUDfoEm5WHpRS92/fbrQRcQmUeyxfRxqZ+O1+7J9jia9/5iAvreFgCjzeaOYzPF3ZQVCr7Ze8ljXWndH5HxT6T7n26+/YtzQBELoihlfQj5JO3k2YTobP59VgKPbuwflPs5cDE8x+HAX/GsvJagzr94FrT6/X8klLCw5WLVUKlOXkIkL9XDu73VwBG9ZTMVYg0v30RZgZTiOhWZGBBYOkgvZ6jf45GbR0I+6dgZQI41A/js0r52sXrvwb7RCj0PpOG0R1FCJzkOicrUi9oB+t5rxVszrncj+nLSU64m/32itSj/wy+Bw3zel09z+pXhqINC+xBn+jeGpfuesLpl18BtifCD85w6pH/hQ73R8HSpLjtkmRPX9eDXe6vPxlNY95nPVmB3aIyrmkmjDvK3Y5yGk=
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2017 19:09:46.9331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0701MB1224
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59159
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: steven.hill@cavium.com
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

From: "Steven J. Hill" <Steven.Hill@cavium.com>

Fixes: 15f6847923a8 ("MIPS: Octeon: Remove unused L2C types and
macros.")

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
---
 arch/mips/include/asm/octeon/cvmx-l2c-defs.h | 37 ++++++++++++++++-
 arch/mips/include/asm/octeon/cvmx-l2d-defs.h | 60 ++++++++++++++++++++++++++++
 arch/mips/include/asm/octeon/cvmx.h          |  1 +
 3 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/include/asm/octeon/cvmx-l2d-defs.h

diff --git a/arch/mips/include/asm/octeon/cvmx-l2c-defs.h b/arch/mips/include/asm/octeon/cvmx-l2c-defs.h
index d045973..3ea84ac 100644
--- a/arch/mips/include/asm/octeon/cvmx-l2c-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-l2c-defs.h
@@ -33,6 +33,10 @@
 #define CVMX_L2C_DBG (CVMX_ADD_IO_SEG(0x0001180080000030ull))
 #define CVMX_L2C_CFG (CVMX_ADD_IO_SEG(0x0001180080000000ull))
 #define CVMX_L2C_CTL (CVMX_ADD_IO_SEG(0x0001180080800000ull))
+#define CVMX_L2C_ERR_TDTX(block_id)					       \
+	(CVMX_ADD_IO_SEG(0x0001180080A007E0ull) + ((block_id) & 3) * 0x40000ull)
+#define CVMX_L2C_ERR_TTGX(block_id)					       \
+	(CVMX_ADD_IO_SEG(0x0001180080A007E8ull) + ((block_id) & 3) * 0x40000ull)
 #define CVMX_L2C_LCKBASE (CVMX_ADD_IO_SEG(0x0001180080000058ull))
 #define CVMX_L2C_LCKOFF (CVMX_ADD_IO_SEG(0x0001180080000060ull))
 #define CVMX_L2C_PFCTL (CVMX_ADD_IO_SEG(0x0001180080000090ull))
@@ -66,9 +70,40 @@
 		((offset) & 1) * 8)
 #define CVMX_L2C_WPAR_PPX(offset) (CVMX_ADD_IO_SEG(0x0001180080840000ull)    + \
 		((offset) & 31) * 8)
-#define CVMX_L2D_FUS3 (CVMX_ADD_IO_SEG(0x00011800800007B8ull))
 
 
+union cvmx_l2c_err_tdtx {
+	uint64_t u64;
+	struct cvmx_l2c_err_tdtx_s {
+		__BITFIELD_FIELD(uint64_t dbe:1,
+		__BITFIELD_FIELD(uint64_t sbe:1,
+		__BITFIELD_FIELD(uint64_t vdbe:1,
+		__BITFIELD_FIELD(uint64_t vsbe:1,
+		__BITFIELD_FIELD(uint64_t syn:10,
+		__BITFIELD_FIELD(uint64_t reserved_22_49:28,
+		__BITFIELD_FIELD(uint64_t wayidx:18,
+		__BITFIELD_FIELD(uint64_t reserved_2_3:2,
+		__BITFIELD_FIELD(uint64_t type:2,
+		;)))))))))
+	} s;
+};
+
+union cvmx_l2c_err_ttgx {
+	uint64_t u64;
+	struct cvmx_l2c_err_ttgx_s {
+		__BITFIELD_FIELD(uint64_t dbe:1,
+		__BITFIELD_FIELD(uint64_t sbe:1,
+		__BITFIELD_FIELD(uint64_t noway:1,
+		__BITFIELD_FIELD(uint64_t reserved_56_60:5,
+		__BITFIELD_FIELD(uint64_t syn:6,
+		__BITFIELD_FIELD(uint64_t reserved_22_49:28,
+		__BITFIELD_FIELD(uint64_t wayidx:15,
+		__BITFIELD_FIELD(uint64_t reserved_2_6:5,
+		__BITFIELD_FIELD(uint64_t type:2,
+		;)))))))))
+	} s;
+};
+
 union cvmx_l2c_cfg {
 	uint64_t u64;
 	struct cvmx_l2c_cfg_s {
diff --git a/arch/mips/include/asm/octeon/cvmx-l2d-defs.h b/arch/mips/include/asm/octeon/cvmx-l2d-defs.h
new file mode 100644
index 0000000..a951ad5
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-l2d-defs.h
@@ -0,0 +1,60 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2017 Cavium, Inc.
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_L2D_DEFS_H__
+#define __CVMX_L2D_DEFS_H__
+
+#define CVMX_L2D_ERR	(CVMX_ADD_IO_SEG(0x0001180080000010ull))
+#define CVMX_L2D_FUS3	(CVMX_ADD_IO_SEG(0x00011800800007B8ull))
+
+
+union cvmx_l2d_err {
+	uint64_t u64;
+	struct cvmx_l2d_err_s {
+		__BITFIELD_FIELD(uint64_t reserved_6_63:58,
+		__BITFIELD_FIELD(uint64_t bmhclsel:1,
+		__BITFIELD_FIELD(uint64_t ded_err:1,
+		__BITFIELD_FIELD(uint64_t sec_err:1,
+		__BITFIELD_FIELD(uint64_t ded_intena:1,
+		__BITFIELD_FIELD(uint64_t sec_intena:1,
+		__BITFIELD_FIELD(uint64_t ecc_ena:1,
+		;)))))))
+	} s;
+};
+
+union cvmx_l2d_fus3 {
+	uint64_t u64;
+	struct cvmx_l2d_fus3_s {
+		__BITFIELD_FIELD(uint64_t reserved_40_63:24,
+		__BITFIELD_FIELD(uint64_t ema_ctl:3,
+		__BITFIELD_FIELD(uint64_t reserved_34_36:3,
+		__BITFIELD_FIELD(uint64_t q3fus:34,
+		;))))
+	} s;
+};
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index 9742202..e638735 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -62,6 +62,7 @@ enum cvmx_mips_space {
 #include <asm/octeon/cvmx-iob-defs.h>
 #include <asm/octeon/cvmx-ipd-defs.h>
 #include <asm/octeon/cvmx-l2c-defs.h>
+#include <asm/octeon/cvmx-l2d-defs.h>
 #include <asm/octeon/cvmx-l2t-defs.h>
 #include <asm/octeon/cvmx-led-defs.h>
 #include <asm/octeon/cvmx-mio-defs.h>
-- 
2.1.4
