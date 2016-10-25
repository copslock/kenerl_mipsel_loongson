Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Oct 2016 16:45:26 +0200 (CEST)
Received: from mail-cys01nam02on0078.outbound.protection.outlook.com ([104.47.37.78]:35950
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992212AbcJYOpTLi6eh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 25 Oct 2016 16:45:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=8iJLHdG+mSEvvW+7wmCdiwW5NCbykq29fEQR4FpUrV0=;
 b=2XgMVChgtb+LwK2KT4XaIiFEH/YuuKjzop83iuX3A8See2x2jO4MPCs0AdTMDEPjD2lzSOjSze5oZpjh+Lk2oyG7V5CSekDkvzeQ9b0y/uOMgsCmthg4W+7c3Tdj/+IvqMrwcfYWUQ2NPjHUYnC6QyZqu7CHG577E3xVJbeD0Gk=
Received: from BY2PR02CA0004.namprd02.prod.outlook.com (10.163.44.142) by
 BY1PR02MB1244.namprd02.prod.outlook.com (10.162.108.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.12; Tue, 25 Oct 2016 14:45:11 +0000
Received: from SN1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by BY2PR02CA0004.outlook.office365.com
 (2a01:111:e400:5261::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.679.12 via
 Frontend Transport; Tue, 25 Oct 2016 14:45:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.crashing.org; dkim=none (message not signed)
 header.d=none;kernel.crashing.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT009.mail.protection.outlook.com (10.152.73.32) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.679.5
 via Frontend Transport; Tue, 25 Oct 2016 14:45:09 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <soren.brinkmann@xilinx.com>)
        id 1bz2yT-0002gb-8d; Tue, 25 Oct 2016 07:45:09 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <soren.brinkmann@xilinx.com>)
        id 1bz2yR-0002Fl-Uj; Tue, 25 Oct 2016 07:45:07 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id u9PEixTV001600;
        Tue, 25 Oct 2016 07:44:59 -0700
Received: from [172.19.74.49] (helo=localhost)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <soren.brinkmann@xilinx.com>)
        id 1bz2yJ-0002A1-GG; Tue, 25 Oct 2016 07:44:59 -0700
Date:   Tue, 25 Oct 2016 07:44:59 -0700
From:   =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Marc Zyngier <marc.zyngier@arm.com>, <monstr@monstr.eu>,
        <ralf@linux-mips.org>, <jason@lakedaemon.net>,
        <alistair@popple.id.au>, <mporter@kernel.crashing.org>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <michal.simek@xilinx.com>, <linuxppc-dev@lists.ozlabs.org>,
        <mpe@ellerman.id.au>, <paulus@samba.org>,
        <benh@kernel.crashing.org>
Subject: Re: [Patch v5 04/12] irqchip: xilinx: Add support for parent intc
Message-ID: <20161025144459.GF14444@xsjsorenbubuntu>
References: <1476723176-39891-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1476723176-39891-5-git-send-email-Zubair.Kakakhel@imgtec.com>
 <32f5f17d-7864-c782-7a6f-03660b7ab055@arm.com>
 <581adf44-388c-f8e5-8437-59d7ace2fa8f@imgtec.com>
 <alpine.DEB.2.20.1610251246020.4990@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.20.1610251246020.4990@nanos>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.0.0.1202-22658.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(6009001)(7916002)(2980300002)(438002)(24454002)(377424004)(199003)(377454003)(189002)(33716001)(8936002)(81156014)(81166006)(93886004)(33656002)(87936001)(85202003)(356003)(85182001)(92566002)(106466001)(7846002)(586003)(83506001)(189998001)(9786002)(110136003)(63266004)(57986006)(76176999)(4001350100001)(76506005)(7416002)(77096005)(2950100002)(54356999)(6916009)(305945005)(4001150100001)(86362001)(50466002)(50986999)(2870700001)(2906002)(5660300001)(36386004)(4326007)(8676002)(9686002)(626004)(23676002)(11100500001)(1076002)(47776003)(18370500001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR02MB1244;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;PTR:unknown-60-83.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT009;1:eoqFkQiFlUgMWsgdIFXBjohvGUB4Qor5cnOyQ0/VHkSP9d6Yn/W+ad+sRcirHYegBFZ35dzwmD/iGETNg2pRyfR8P+Hu9vPNI0ecVZd/QgqgnatiP3+zWCr2OQ6/dCaJYCJvP+A2QPYFZFaxRSW6WlBU8HPqFR1SA0LoDhmsglmBhQT46nUio1uknp1fvbnRLFbNTxWVPtkbfEMDSJG7jrO3Yr7DvmXsslLvKuXLWSi9nyqHwcE46Xfbj+BmC9+wt3j58P9LAMIUZNqQZXDidxJR+hXbXsU2+GBRH+0eHXgQkUuAWp1yFsrYbIHtoVl61B3gEIGnaRfWgZCYjIB0MjEIBrw3NOkijjbCkfpioE/KcVMBBxEw/oDuO+s/YY65v1Kzw08rdGqJ8ZLO/TAMj4HDBOkHqCtPw16HWb8bLqIJWhjHRUsOyFQSdeugcDqKARbFoQ1nXAdBeVfzWYmqOvSHwKfL/lKgCYGhDklmrwnnQZEKi6kBQplPtYWpVbCi0dQwyMweE4NtToSNLes4FacBibn6nM3UpJW+oyuKJkZapcAnHjhkz9o9D+1CRX6lENMMt/vt4UKb4fWv23ed0twvuYee40lqwLTbHQIs66WjCC6KC5l/eznrKf9d6Iqe
X-MS-Office365-Filtering-Correlation-Id: 94b52f0a-ad4f-4208-0f75-08d3fce58551
X-Microsoft-Exchange-Diagnostics: 1;BY1PR02MB1244;2:p7wp0trReYQW48s8Sw5Q0sH9OdyjpZdL/kfLbt+CrRj2XC+orOuJIOJFZnUbcIfzl4CTOUD1xdnvnNvedjt013lCVk0Kcl4nDcCrpxB2SGxazoYZ+QaXruY+78Temd9V/WgtTuLhH9/fRdaA6PvWpM29KVCbO+Afu5DrlBdBg3qGkF9jUFsFQ2PJNv0iHWFdU4n/CyF7y9ar2aFfrXA17Q==;3:Af+Wc3STmYtf2PFPZMpozhbOad47DryJZ/RS2qd0qacXbpWlSMesBQyVIX+ZDqaWFzkdd0+sghjyhFkNWqSfbaeAJq+Qe1jwi920pofu7y/qYxv0zX8WFo+ggFQvlnI/SZqdbu29x/kCC+0j1HADw/cqskqYvt00GW7FW+hZY1WlLH0v+mjEMoIX08lSogHoGv4d1xWEBFxSU5DMIfS9XLWbVoalvd0ZiduMYzIGX2fi/QvAXapDzONbrOZXe0G8wbav4zaUoOO2BxsXyq0a2h7tc+0J+JFStPJRNUFKAIo=
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(8251501002);SRVR:BY1PR02MB1244;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR02MB1244;25:2MPgEmE10gOx92tR++7PGlr1kt9ovHX9+uDK5x73tmW3r+HcQkkBAwWbAgQlW/MwuFOPumC4tnomgYvywRoHzDfoaJ61bPnzC+GeLfdN80MSRlJCNH2FWAguoYKrRp/OjxPL76wANjdy3OsZZrjOEhY0Rc9eU5vXdlT4HEjxT4jz3ZIScpTEgQe/6LcCZVETUQDhXovwz5w10iAnTrlK8+WrL6qzsobD/CNVEIe92xAMYV4ONYwR8XGgcZmBrcMIBgS/pB39C2ovgPV3WwgSUvQOGfiHYo+CoHueKhoU8lF2YK97MiqWD7GfrqOCDGsdfw410qTEvDM9xSv34FCRzRnYwuTzcGuzEcNMM1laIMl9u/Zdv36NNM1NwuKJMK96oyNXxdzN3/20Hh1jbAWTYoXRfpIWqHzEhQ57GzWWIAuobfK16ph19SzNrDTvTHl+XYyU+UEOyvy1Q+Yncb4ZPMcrWS/AR45hS7gRyn5c6/VZhytw+Wt89rmlZQoD4S9axhMD6/mT1d8wChj/OtNol8u9ed9csfIMuzqz6W9myoHqy5T0L4tRO844ggxOs+/N+5MdFKVyya1RJC1mC11EARMOmjA8F4bpAfxfDlfnp9+PBJf/BcN4oOPZAcbeHQkbByEmqTUt/s0t+3yHneVOnUMxKIF+zVxLKOdjPWwjgqjDj1O3BBoiw46PnX72468Avpg7DTLTX7fsWmKZ47NmTAjU9ZKoVSF/vylgSaE5uQHo7bZ2qXH4LTXzpLCUb8w9hEFugtTLz6ed81d5ktsl/IDNEa2eHfEpxeLEGEjZt6udy0JfiXEq+4GRqboHZmn0
X-Microsoft-Exchange-Diagnostics: 1;BY1PR02MB1244;31:fN07uFNh/5sJNLTO/OeCjhE3A+IlhhGuuhszKiaRc3UdhfirXomE8tOlbBKXfCqiRmDrUKdFOMCGIofshyzLIQULKpT3Euli7fcw8+57ZqP71FhnF7GLAgq/3ejuK5iLNSsElmbSfzyP4iptqP7igABlgfrotZQLvJew24P1S4hmeP+6DXB37b9S9SaqagTN8zOpNKYq8m8yQ6oZrfdDvd0928xbotHrhHQsxbtVR1uSptctzN+2dkiz2i4GDJltgEjshYx1P7CuwCwvS9zajw==;20:9UIwY9FHNuhz/ADoupH5jPj00nQ2UT9z2WDTMnNJBdHlOdJLpBD94Ot+jfW9DZRnv8ebeKcGWlQ23kN4d+sP//lcpjQUDIJnQZWjiBpJzBHbnQnzfujNc5847A5OP8zzSevt+rxev6WLOdo+a0VV+6YuoHlyBgyVxpJShdA8x6SU/CLsZ3sxds+eUHZJHvs5RpzUhZE7N1ujU9vrbMsKpCeLxqMbNi+t7xPLUfLmATEIGSIZLTjiYp2KgEDQKms/v7oj39YKDV5SvtM9xCWM44hwAiePZC3yJHrZgjnMFc54eSLSa7sh1Wyd3yRG4W40DLfHRHDxBO4oWZOO59F+9gwsHFVg2df3QwpRFlSfI1s6UsQbn8TH/oESVkdu6iUf/54zpc5A2e3MpZb2NkGHnCo+JCUx7pzD0YxvBmQeCV/E55TjZDoRUp+n6gFB5IN1Riwv9dkC/xkeorR1ptJKmAyUbfFgY/xU9oY3m/kQZ5Se/bp+NiOUQYEC49svrXLi
X-Microsoft-Antispam-PRVS: <BY1PR02MB1244F3FF3F89BC020C6AD2B38CA80@BY1PR02MB1244.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(5005006)(8121501046)(13015025)(13023025)(13017025)(13024025)(13018025)(10201501046)(3002001)(6055026);SRVR:BY1PR02MB1244;BCL:0;PCL:0;RULEID:;SRVR:BY1PR02MB1244;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR02MB1244;4:9Ky0FqGKH6vEg3tgPOoCuEvszjfdAwlaZf/E32eOOBst4f9Jg71XooXPf40/nKI0FHVjUMge1VUjA0M93Supekja4l6ZM+0bQbn0Gb0tvqGYMmmsSrow9vNTsvVmhRAx2V0xRk8myuCpLwLRH7EAhnENwvnhbefGjbi0EdHXX+G2V2KF7jT0BG6kulfQt0tKH5BzEscaa0rf+hXZckLFxx53Hjb2+MkDD2A4ynzdagemRXMiYq1+NId7Kfvb4rrtuK2ZgmJt4ckQbSYpeo9Yf0rU0J8Hr5ASoo4uuqpgcUhDikI/AsxiQ0+bllACq0lsZlOvpX96ncf8BzBZ7G1lUatpKBf9BSSABI2ILTtJNHTbL8KyMF0nqXP9aA8NBg0rr70gCy//gL8Gk6TZrtcyDmYRcXnyRvhqZMMRS5etvsGruBRm36meUQ+33Y5AYjH4H9MxkIYnXQxCMroxWqy7vS3qhUWF397pAdDo+A8+ThqHOi9epgEpb3N7EzKu6pEUL7oXO17Py3rDxwkjIedC8A==
X-Forefront-PRVS: 01068D0A20
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTFQUjAyTUIxMjQ0OzIzOjhOWUlTWHFyQWZIZDlrMUcwaXhURzREUFFR?=
 =?utf-8?B?MnBCSEVkNDBBUkVwdTNsdWo4bUhQNXZnU1ZGYzlCS1A4SkI4WFA5QkpRNWJS?=
 =?utf-8?B?d3E2YVpPanN6b2UzMW9vWW4vNlZDUEZkVC96TUZORk1YTHEvYVFCN1ZTY3Iv?=
 =?utf-8?B?dDl3UWQvZ1JTc3FDRm5wUlZzS2pybEFhRktOZUxHRFFqYkg2Y1RkSVhGUWpW?=
 =?utf-8?B?eTdSUlNCWDIzdWljQVpEdUVQUVNxUlU4ajVNTk8vUUJwYXNnSVc3UlFSckFz?=
 =?utf-8?B?YWJNS05aYkowaUtFeHQybml4VVF0aDljNk9GRkRhMGZvL2lTVzZmRVpQTHVi?=
 =?utf-8?B?OG9QVlY2M1UxeXNYUXltOGRkcVJubHpNR21YaWhySFJYQW1IZEpoUGdmczJQ?=
 =?utf-8?B?YWVFZlVNOTlWc3kvRWIyTGV1TlpCVHFUdGwwSUxrWnFjODNtdVJDU3lxL0xu?=
 =?utf-8?B?V1NwZGNndzBWQkJHN1ppcmlFdE5JVXFYaldEbTZ4N2Q3TDcwSmU5ZnNFbUlO?=
 =?utf-8?B?eExaVGVHbFBiL1VaMUROaHJsVlI4RU1XcjlzdmoxQjVMN1VjVWd6N0V4QlIx?=
 =?utf-8?B?Mm1XZUEvTVY1Tkd1V2tQUFJkVkFlN0lNbGZyMWJLN0tWMDZOUVptalpDaW9m?=
 =?utf-8?B?c0JTMnBoY1lrL1UzVE5GSUV4UGRxNm1HK0Q5OFI5eE45UVYzQm54ek5hMWpK?=
 =?utf-8?B?Q2dhNXhKMGxaOEVKYjhkeldlZGZIb21HUEh5YUFyY1htZmZsdjhvdDRoL0E5?=
 =?utf-8?B?QUJRUktRTndWeW1lRGx1WUFERFZFeGtiU3J2SENCbWczSGswK3dEVnUvZ2Zw?=
 =?utf-8?B?alNjVUd4RSswVjY1TS9FZWJUMzFwaXlSaTNLSHlkbHNESFlXTUQxWEtma2pz?=
 =?utf-8?B?MVNya1drQlIzejFyYW5XWFhVbUtZMlJHRlJ1RlhXMzAyS2d0eWMzTzVNeHEx?=
 =?utf-8?B?bnVsak1GajFsRHBVVERZd1ZPbHhsdlpIcGVBaWxOMGNVNUd5UURVU2lFalBm?=
 =?utf-8?B?Q3doN05pOUJQL21sYkVWYk9BK1A0M0tVNk40b1JZK1hNeG05b25QYWhVd1JI?=
 =?utf-8?B?Vkp3UE42K21VSFFDMmpsM1J0Ly9mRTltMzdjTjhGa2JFT3RYUDVHSnBCWkRY?=
 =?utf-8?B?ZWVzYXgrQ3B2dzh6UENyZFc3UTgwd2h5MENhRjJoVkpjeEE3TWwyS1VoUjd5?=
 =?utf-8?B?TWhwdzRkQkE4WXQ3bTF3WUxYOGJ0cTBEdlN5T3MrR2JXT2JyMEd0eHUxTUVR?=
 =?utf-8?B?SWtqV2xPT2h6QkNjRC94bEEwdkZoSTl2SXVYUmhnOHZQdmtYWUNOTWZWdkNV?=
 =?utf-8?B?dnhpRU9rQTFvNW1PbFdVLzZZWXYreSt1Tzc0MTVQZDc4dnJaU3FUUFhHUjFy?=
 =?utf-8?B?a25jNGN2QW9JbHI5NUllTnR6R1pLbjZZYWRVY25wRWM5NUIzek9PdXBsd3I3?=
 =?utf-8?B?VGsvSk5aQVFVVWpyTWE1ZTltQ2RVTGIzNXNQMDZMS2s1U2Z5SnY4YWtCY05Y?=
 =?utf-8?B?Q1dHajhyL3VGTmgzb3NOY01TWFdwRlluOVRKUGQxUlZhUktmSkxFMVRUc3Nn?=
 =?utf-8?B?R3Q5cllmRlRrSk10Y0pqUFdLQWQxYnl0enRsR2U4Z2NZdnFpaHBxZmlnd3Fl?=
 =?utf-8?B?TVR6VW00cW9vWml5SElWWUJNZ1F4NlEzeWl5TUQxQ1dyOGFHbGZCeHVvM1Bi?=
 =?utf-8?B?V0s5bkNTOVBUYURvNUl3YTFRUG1ldmhqY1hDTG5kTUdJWU90UWVYdGx1QkRw?=
 =?utf-8?B?MFdoai9YTXpHUnhRNEN6Z2ZzN0lINFhhdlZNcW9HYThuTnVXZWFGejdLSjlE?=
 =?utf-8?Q?+kWJ4cjmX9kOO?=
X-Microsoft-Exchange-Diagnostics: 1;BY1PR02MB1244;6:Ef9/3pOJjMXwmKXZyIIO/brNSWR2ckf3NNmsFrcsSATxyMnc/SsBMPpImuRIL9V2+PI/VH810QttXmSB8i+PgJCbq+OyHRdzaKSQi7piwwzTmj55RyZ1Jb+NKzheHjpPGQTHJUEduxYIs85dy329WGlPd3OJZQ7/NNVpWjWOaotIyk88Q9ve/oCYUb+a5NWcMW3+5iPNdw2qLpoxU5HUzP2bL5HuiKi8/Kvd3CAzDaVWyID4hnY+6dOGG3Yso838Cb8DirWAFVyPTveBx2rlIZciQRyXR0XNhAzCgQFNnFn0+Jha1X5bueaSIJrKimU8eKAo1Ir3IcOgXSvWh4PGCIqzjgsjMpfkkM6J90wxB1Q=;5:3JTpcNnlVnLa6NfFzn4hEKJgsMiyzHnulfaZ39Y3z5WuIxpYUFErobuwAioEsVYxDxifjkR1Gi21VQ/is8+vBrpx8oZTSsJMJBDmtNezPRX6qrzHTqVjhTlfRvH6ICC0W/zA7uN3pI0fASlajzfMRg==;24:sK+pVG8PM2itB3CVMXV8otKV6WYPiR/m0H1rMqjVmOR6geB00K4jADLncL5eoPC27vWBrJtKTE94QRxyKaRyKaFxEPo7TZWCFx3sXAucTYo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR02MB1244;7:QbC92zPoMc+glKv4sAkxxlYIZCw4bkp2g74J4oKhs4e5pJNDoFAFxlrQZ8q0/59P70mVJdwNAbYHea8k/Uo2ZUmLSBG6H3QixNIUaizJy2jYdNTVqH1OQmRuTx+z9OtN0ErzWjlC0DxqtMmzAYZw9kZ0hLG39t88Ssl4PNgGadJhHvPkcHVg9kmATQ5UgP0+nzBaRmzusB38EZVZtwyswXgybkKphzsDc7N8oPBeTJWBVAjhYfMcXqXXn+NuKu4M3sta02SzghM8q3nPQb193nd4Nau7DWQHYprFO7+uPh/twsEpOL+sVh0Vk0sPDfKUgPipk8vf8ZWCSrPgi6UZDb+ye5acU9nl1WPTEfX0B2M=;20:vlboU/W1j6MRIn9QYBZkyZfPzTSdB8AtCj9ooLEbLzApETZ3fvwo0VU5GFcRUTthIcA2KpAH6iOzU1HJoOP1qBX1F6/RIDNIZ5u7BGUybdWhfdDx4rFiI9zQ5JZE1sKP/Ip8VqppARPsfiBj3Gydrr+b33tktPN66lSyR/3Hvg8=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2016 14:45:09.8139
 (UTC)
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB1244
Return-Path: <soren.brinkmann@xilinx.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: soren.brinkmann@xilinx.com
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

On Tue, 2016-10-25 at 12:49:33 +0200, Thomas Gleixner wrote:
> On Tue, 25 Oct 2016, Zubair Lutfullah Kakakhel wrote:
> > On 10/21/2016 10:48 AM, Marc Zyngier wrote:
> > > Shouldn't you return an error if irq is zero?
> > > 
> > 
> > I'll add the following for the error case
> > 
> > 	pr_err("%s: Parent exists but interrupts property not defined\n" ,
> > __func__);
> 
> Please do not use this silly __func__ stuff. It's not giving any value to
> the printout.
> 
> Set a proper prefix for your pr_* stuff, so the string is prefixed with
> 'irq-xilinx:' or whatever you think is appropriate. Then the string itself
> is good enough to find from which place this printk comes.

Haven't looked at the real code, but is there probably a way to get a
struct device pointer and use dev_err?

	Sören
