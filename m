Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Feb 2017 17:10:20 +0100 (CET)
Received: from mail-he1eur01on0106.outbound.protection.outlook.com ([104.47.0.106]:37319
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993177AbdBIQKIrDx1- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Feb 2017 17:10:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=BhNaaTCwaV+YksyQf2ds68FQFJBk1txMz5rI9eEYJdc=;
 b=m4u1Byi/1NMedwlkULGmkg+4/cFBtEim9QP2EjBj9hHEKhEqHAZT7BEsx4oztgRSuWxCPjraWtDzKNitDbpazngSRCwlBUO8VDUSJ52oClMYTBpawkfeAcTYEWx5YpJqwrkO3hX+CkWgsy01+quuZNOwrEj3NoFjUsxOiR7uX8Q=
Received: from HE1PR0701CA0079.eurprd07.prod.outlook.com (10.168.122.23) by
 DB6PR0701MB2917.eurprd07.prod.outlook.com (10.168.83.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.888.5; Thu, 9 Feb 2017 16:10:01 +0000
Received: from AM1FFO11OLC005.protection.gbl (2a01:111:f400:7e00::192) by
 HE1PR0701CA0079.outlook.office365.com (2603:10a6:3:64::23) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.888.5 via Frontend
 Transport; Thu, 9 Feb 2017 16:10:00 +0000
Authentication-Results: spf=pass (sender IP is 131.228.2.36)
 smtp.mailfrom=nokia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.36; helo=hybrid2.ext.net.nokia.com;
Received: from hybrid2.ext.net.nokia.com (131.228.2.36) by
 AM1FFO11OLC005.mail.protection.outlook.com (10.174.64.132) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.888.7 via Frontend
 Transport; Thu, 9 Feb 2017 16:10:00 +0000
Received: from fihe3nok1346.nsn-intra.net (10.158.36.134) by
 fihe3nok1347.nsn-intra.net (10.158.36.135) with Microsoft SMTP Server (TLS)
 id 15.1.466.34; Thu, 9 Feb 2017 18:09:59 +0200
Received: from mailrelay.int.nokia.com (10.130.128.30) by
 fihe3nok1346.nsn-intra.net (10.158.36.134) with Microsoft SMTP Server (TLS)
 id 15.1.466.34 via Frontend Transport; Thu, 9 Feb 2017 18:09:59 +0200
Received: from fihe3nok0735.emea.nsn-net.net (localhost [127.0.0.1])
        by fihe3nok0735.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id v19G9hM3030250
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Feb 2017 18:09:43 +0200
Received: from [10.144.202.132] (CND1130BN4.nsn-intra.net [10.144.202.132] (may be forged))
        by fihe3nok0735.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id v19G9fBu030212;
        Thu, 9 Feb 2017 18:09:41 +0200
X-HPESVCS-Source-Ip: 10.144.202.132
Subject: Re: [V3,4/8] MIPS: Add NUMA support for Loongson-3
To:     Huacai Chen <chenhc@lemote.com>, Ralf Baechle <ralf@linux-mips.org>
References: <1403754092-26607-5-git-send-email-chenhc@lemote.com>
CC:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        <linux-mips@linux-mips.org>, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <b8d91f17-35fb-6a22-18d2-966779b5714a@nokia.com>
Date:   Thu, 9 Feb 2017 17:09:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <1403754092-26607-5-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.36;IPV:NLI;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(6009001)(7916002)(39850400002)(39450400003)(39410400002)(39840400002)(39860400002)(2980300002)(438002)(199003)(24454002)(189002)(54356999)(65826007)(50986999)(76176999)(356003)(54906002)(230700001)(4326007)(5660300001)(36756003)(31686004)(64126003)(65956001)(2950100002)(50466002)(53936002)(65806001)(77096006)(97736004)(39060400001)(23676002)(2906002)(81156014)(81166006)(33646002)(8676002)(47776003)(305945005)(229853002)(106466001)(8936002)(31696002)(68736007)(189998001)(86362001)(575784001)(626004)(53546003)(6246003)(4001350100001)(83506001)(38730400002)(92566002)(22756006)(2004002)(42866002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0701MB2917;H:hybrid2.ext.net.nokia.com;FPR:;SPF:Pass;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;AM1FFO11OLC005;1:sTVt3QrbQei1MxrJhEdovsyUzdbj06EuKjaW7y8WuY+4+pSCSbSmtSv4wZg5cB/1QrDEvdFu/yuPoa/x0LABr7vUjQfaymIrey0CFp7xRURTxIF+9E5lPQ2pOii9vYUkTdH7SxkEA0efXATcwJJSAcmacf/h/qibFBaJNjVc8yaFnH71/OjmjUMokpqjEkdC7AZ8nOvRs6EvHrUICEh8k86aRCHhx52iajA4Q8Th+q65YV8G0GGTsRvHXcElxIjwlzfh+IDAorWzBZqtgMqHWe2HbGK3bZDBlpgPEtyKa550ChXOsZQd/TTHeimGmBjKHaKSssD8v/CKo5pRyluhYdBbZzWyrMGBMeGEFVvhirDGNVkLn01iO4v2e1/8MGNXBLOkFX9JzN8IwinebDRiAhfF0D77oVWp9vqalgzJL2UE7OVQpXLHKcFvpCVrMr9pQrYUUkm5J1WLpnUhkwSZSqrNHudrN5bBcB7m9Ozf8igCY03MLHRW05GRlhjN4ul0SX33qSABHI9A4Y9pNm/4RQ==
X-MS-Office365-Filtering-Correlation-Id: ce480c0d-4673-4a00-696e-08d4510619a4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(8251501002);SRVR:DB6PR0701MB2917;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0701MB2917;3:fFfDPbrswaRTsU1NgOPMHpN6DsmXVRDiNMfU81xWdop7PdqIEQmL4ilN8Dlbimaffd30AgStudUdALjfL6Y//UxS4q446PY3HZ4Zsk3010SnMUSI+fpl+/rFAMuWOlkZ2RV2P8pGCthwvE7yVlYtWBkDXxJd6ev782HksyETMrtfbCVe+tnjFCgPkmvj6F6dmU1v1bjMlOdkSoi9J9hIMP10D5ro4SO9ji0avIUqMciW+mg2zauV5DWNzjI6qz7naNqWsrP6AuX1PHUSbSvo+pP8EGBPmmP0ke7FHi/H8tTkYtHw58mziJsXJzAEZ+xYMeruFPDfgF/ga7+XmjPoaoh1l49oEo98K8oLPWAlQxfjUX6xbwYodjjp05pNdMNmBRAFDzptnxURqbWge2tHhQ==;25:tgzqT+DNHev8bWYKZhkfljURiBNM1R68FC24FZQD6nUbQdjtfQmpkLDyaJ3S9Aecne1M4o5HRNyP0hu8hIEjI1XIQvy8KCAXpPlVnplhAeIGbarHYl514fAgkScANGgGmSPZsMz5pP+cYpc+5vyJBZ2dBg+cULP28YuL9vZZsiWA47RoPJ9lj7BXnRVd1OqXezUMGmKfo1Y/FzGZ4CtWq4UxVsXAsloiJgSe4j/8NRFAU9KnpGLnwJTUIcUGQn2UzQMrv2wTwQmD+KeJgQrSkPWAFVIXO/mLJZd7QwpWSXTRiH5PDrPc+GsiOyoMWnD43DKGulRuGe1QvKdS1qpXmlbchrHvB+WC8XjqWHdgUwjNcF3zozSPHeJrkMK5gIxH8O8dCtWTivPM1V0ZPyQDmEkjAgIUeHvwqSPoKAyfTVxe+qbqIS+5dFEstR8q7n44d+ABmeBCKt9QkN9o33tckQ==
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0701MB2917;31:lpgZoj07246UxOL2pXWmUJnxpftf6Xi1ig+3eiGFWoopLGp4TAL/EfqppVry+iLCgN/BPJj4emuT7b4XHtCDEm80WxbwGa/Tyfz73x7toar/TcxEPD5DfHp6dTZAEi1sigh0fFzcPr6qoenPf/Xs0Z0vgUpO2Flw3pAhGjOGPks8tmkKAM0nOdE6wGsyv/fvyuvAaUp2fW0dBW8yZWO70y+cQSOSRJwovVEluMLhQcvP8zPzwsqc2aQCOJ3LIllQKuOQK7calB00MMSk3AH0B8oANw1GTdxfO4N1ksvJrXA=;20:CRQRmfhRno6gH2T4A7wbHBaIHGlfqdW10CWb+ZphA11AVuEXywg28p3XMW2pHsg/o20iBY7GwyY4Ev/skbJEGoL1KyPgIWw6IVCxtO4NagL8C2m3EsFzq9zqat3wrU1URLKYbtjL6M5j5AwSQhh8lkRUSuaBdFNv8u7n516oKxhTsKaKWvL0oBDyMVp/MdijKOKaws6MMPKuYVxqxz9sJV5TCJ2j6emTwb8RuXtDP8013knedX9fxcdf1jqXwNj4yJcFkhzeqeFpyMSI5T8mDbWTk44XLrTXKgkOvLiB3uX+DYb65+odA7al5N87oeYv9RPdYW3QAj4FX6wDFOWv7+kneFbP4VBZAhIs2suYL29TCx5t7N7m9ABhG/7SSKLB+fmcghTMbgSVz6C4j3/g3+9WxIL4hZs1gDJcu/iFUoGN/j5vqu+u5ilOIslE7wHYri0fEq6hh/RZNr/VzKC9pL1VhCAFEjxZwnBGiSCNmuWS85X8y5cj7C1/OPDo83bnYAoiBGIZOYXvnTBGNstJUtp4/j5THO1I/F0zitZyLe8QHIWJ4kTlIuCrCqPUGiM7yoTfMnW+vv0iN7fyXn3pUt0s0InmREV2O/WnK64e+dQ=
X-Microsoft-Antispam-PRVS: <DB6PR0701MB2917709DB938A57DC044290488450@DB6PR0701MB2917.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(13018025)(13016025)(3002001)(10201501046)(6055026)(6041248)(20161123560025)(20161123564025)(20161123562025)(20161123558025)(20161123555025)(6072148);SRVR:DB6PR0701MB2917;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0701MB2917;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0701MB2917;4:tQDUFufE7lTL8tcn+P834NeBzNBUJwQZSnS3BDHCFVlOKFFn12RH9Gf0C1xcv0UubrNBjqgDT1wqScANx7lpZIkrq0Bfeh3i7QGgPexD7rYi3lg0MCKjirxygU1SGG2NBAOVI8Y8u71uw6FUGmTHGCeheUHz4JmwVbD2JVNFPD5uOSJIa8U0d3bwU5X/uuMRWfOtlsQMWGJRa8vuZSO+cEB1hAbS1oY4Q/JSUQikTNdAwSdiFsaQjkYDgg4EShJPMF8CHUyGV5L04a6JwFX/9m6bkCCpBLryjUOaclEsF49xeXihja/+lLI/QrPVwqTKrsergcF+SKoqDpEjiXe0E05zU7drEsHUggOisfF5VZ/IGgqdAzJTD5atngPDtS+L1ecVra3l4baJW+eKhqBYIm3OK9UV6X6Rr6R3aNOulMIyinP1EZvwvevNRojajQz1eNa8buSCY4VRLhjfS3lnksBpJTSiOd8jO0SMC65QY7iAayoWSvjmZhFPUSwgeRv/0aDFUZugRlVMh9dovZnBwanvFL48AMc7SbugtoiwyPe/OFXMNiCchGXv5UgMB7CqHJi/rmrPiln33KstulMNv6T96kfwf5p8Ur9EsbVZZF7z2SNtw+K9m6gCc0JJ++qJ82c5aTIwW7hEkcLk7LD5CA92pfJqJ8MI3oxk/zX3p8g=
X-Forefront-PRVS: 02135EB356
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA3MDFNQjI5MTc7MjM6SFllejQ0b2FZN3NTTUhRZDFYN3M2LzRG?=
 =?utf-8?B?WlhjY1p4eVZkSHc1UjdHNmVLSXRtMERIM0ZzOUNZei93TUIydWtheU96NklL?=
 =?utf-8?B?TUFPN3JUdU9nWHVzemhtdnN0a2lZQlJYYUJieFhKaTJGRzJTSnp5YU1XVVU5?=
 =?utf-8?B?aE9VZG5FUXo3OUVONEdmcGQxUyswcUV4d0JMY256TmJmOXdIUVdseVFwTXdE?=
 =?utf-8?B?NEduekUvYWE4VUFCb25uZW11TThWODlmT1lrVDZIZzI4VVYxMWZpeno2MHZN?=
 =?utf-8?B?OHJqRUtTTHlTZTFZOHBaY1lOMGQrT0RCNEoxOGJabUJQbDNuVS9PdnJBUTNl?=
 =?utf-8?B?UkJCd1FzajBmcjBsR0paWVR5WEpGT0htbE8rUTN3S3dPczFOTXdCUlhMNFdO?=
 =?utf-8?B?VWQ2WkdvOGNpSFViSkdaMEFSK2g3dEFJR0xkcFdFZm1tNEx3RU5RTFN6NDgv?=
 =?utf-8?B?L0dNWTVNNzNPbk1Qc3VGVlYwREVNaHJtU3pnRlJMMWc1TCtvcHRTZUxzRVVR?=
 =?utf-8?B?cmdwUldwQy9panhnOFN1bmd5TXZVdFdQSnl3RlZ2eEkxamNqdDlBTmxpR0pG?=
 =?utf-8?B?d1pqdS9RZVRITTcxOXJNNk15OXdFUmN0QUI2NkVYbDlwZXJ4VmVmTVRlREpu?=
 =?utf-8?B?Rmc0UWZBMjU5YWRzVVZWM2xnWDk2VUZVTkJxeWpKL3gvNG4wOGFycjVVemFy?=
 =?utf-8?B?ekFYQXpYUUtkaHh3RmVDOGFYR0gzUCtQamZvTCs3Q2ZBb21yT0VXK2dxQmZ2?=
 =?utf-8?B?aGlkbkEyM0owWHRIZjdPenJnWW9tUkVIU1JHMzAzcDRlZFJlM24vUmhBYjlX?=
 =?utf-8?B?Szc0VmR0ZmtoRndaVU5wZGpMWDdjTERCaGo2T2t1WWpvVDNka0VOM0tkUGZn?=
 =?utf-8?B?YU1oNy9rd0d1QXRUNkN5cGNMSlFFQXlrRHJSZlMzLzRsN0twUDVRS0N4U0ZX?=
 =?utf-8?B?bnJzV3psVkNtcW9sV0JoNFF3RmQ0cEsvbkhoRUJCNUcrMUtHUVhyTFkzQlhh?=
 =?utf-8?B?Qk8vdVhSNzJRazBzYndqWGtmMmN6UnJLQ2lvaXhWbmE0TzFXdTEySkc5QjlC?=
 =?utf-8?B?bGI2cjMrc3Q0NVUzOE5NUHR0NGZvTUQvNzdIcU1ZZnV2TGVMa2tEYmZrSWkr?=
 =?utf-8?B?Ym1hd0Rpcks3ZWtnTTBmbU53T1NjSXR5VVhqNGJrbnhWTGJVdlF2akxvOE9l?=
 =?utf-8?B?V1J2MUtSZS9Dckpqd2NkWWVoMEthaUh1YVBOaEp0aFkzdk5xZWY1QU9WcERK?=
 =?utf-8?B?TTBMY1VTelpWTnhMNnhDbzBIYVZXUjMyVmd6QkU0WDlKVXd4V2lxSy9ZN2hB?=
 =?utf-8?B?KzAyRTV4Rmd6RWx5TFlzOE9qVFpHV1lMdlRxdWhRS3NyRmF1UnIrdHJmcW9t?=
 =?utf-8?B?ZkNaaE5QRVFPQWJSM29QVUlHU0xhU0IyeVhOY0lJZTU4RThDTHJhazUvcUZY?=
 =?utf-8?B?cjR6cmN6TW1kc2Z0cTFJNEY4VUF0cnBvb2ZES0MxRG1Tcmp0ZlVXeVpsOXFV?=
 =?utf-8?B?a3V2ZWpSWXNhQlpHODhUdlFLTVRNTWNIOFdiOWN2a1BrcS9GMldMWlp0QzZv?=
 =?utf-8?B?OTVHbWduWWVoZFVFeEFSMUY1U3BrV2YyRStyUHltY1N0eEZadCtUV05RcUg3?=
 =?utf-8?B?ZEJodExEcllHRHpENEtzWnQ0bS9pSnJ2THdQUVV0OGdNdDg2YjAvQURmUjRD?=
 =?utf-8?B?anlWaUIvZ2JKSFpvaXhvQlRhc2NCRHRzVjQ5VGdqdlBVZEJ2TVhwOUVWbm1h?=
 =?utf-8?B?aHlmV0o4UEl4Zzk0U2R0OEpiOVNkTldmck5aa2JGNEcxLy9xUTFVcDEzTTZW?=
 =?utf-8?B?OE1Ec1dOWU9VWjlwaE9OUDdBV2pzRXVOcFlkY1I1c0lBdTlSVlBNVDM5dnhE?=
 =?utf-8?Q?0evNSe6Kp7bMSjCB+elle/ppVFRQiyZglw?=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0701MB2917;6:N5Ycx+CmYSYFAEn/YzNCJeLnOaYkzstWcKG4Trngz+vHjmUKKbb3Hazn1mU6u7WgDXx/M3GtxCYpgDCNg2XvmIU2/XMYNinN9SsLDAsoVNP0aBjMfo99W4cO1SIMN8w+qV97tNy7yUxOdKWLF3Yz9ecrZ/IYW1kT88vSHbNTsSAjLGe23L7fDsMLPdcd/tlC9H5MAZcqHpgx31oCCQ3rsU++j5S8MNInaioVTmJh5geZpI4rTk6nDb/cD0St10ZDmm/bS/BbzY/4ibVK6zOV0Da01dQQUPhk/4Zir9nbZARpyOYIiHysmuPDQb2bWgQ/669kSq2tCO02cHJsoK3ni9fs5G7gqdQ2MAxg5kSkfh55+wN8bO+CFeJggoIiDDo7gJlHQlCvgO0GN/YTJEwTtd0s8Z3G2ucKSvbThpgoCeQ=;5:B6jHgDrXWPEpzDSRrAO6i5IEgqm6yD+hmmAY7XFSl71YeuGUWRQkKRvuqQ63xe9V9VGmigzwCftMoPu5nQy8Tg1wQfl60ZQ6MFEwM5FzMrlDof6/OVmYF3V+JTv/hKDgP+qou2arqjFCPyAGOidnJg==;24:/+ahfzy5aNUElC4Foy2wyoTRSlzh1lBMN5jEK2z7wcOtyRDbuhVUKlzhjEkhDIByGOShi90alPISK+H/d73MCIDUM0TaH7hcbifCN1Hl7u8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0701MB2917;7:YpdvB1Sj0C135/9jJpqX9b0iAWkiOQGuJB30XRXpO4KFBt87bvedRvIiQW+84X4fFNZqSbD1e48TAFKN9lN1Go4sQysZ5R1DGq5M8b6DtY49otNbUiQfRpfuzYkZa1E5f5M0w9x4IJgyEq42bqZ1PEhGCHwDHjmVURbUZHIpgNVzqFzqU7Au2SGlt3NGcU+OXlMdD4JXiC/idNuYu60qI3X1ztDlBXsY9/DyGbwAPWJKfZCXG9o2FJdKlFvgwEKkYDttn3mrn+w+P2n5eVSigxflVUFQyFhJaWCHYSWjw3icG8OVqNAi8e5/3w8qUk2g1fgk/2GqSHwAvNHHIGtFZIvKgNS24kOGXDY5v9ILJZy3MQCDw+JC6Wv44+XIP0FBCWlKxIxhwh1tfk1CcDZfO9CP4VxS2vdXAFU0/Ouk8RdITkO9UeFYmu5bzSZdahSOvOUi6Q6dmki3VECZNBsZyXE+jSC9k2D6+QrHubhBpkbkfAcTlHzBVS67KgqAkk80byT7fCJalzNb1NjUGa6ejg==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2017 16:10:00.7161
 (UTC)
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.36];Helo=[hybrid2.ext.net.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0701MB2917
Return-Path: <alexander.sverdlin@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.sverdlin@nokia.com
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

Hello Ralf and all,

On 26/06/14 05:41, Huacai Chen wrote:
> Multiple Loongson-3A chips can be interconnected with HT0-bus. This is
> a CC-NUMA system that every chip (node) has its own local memory and
> cache coherency is maintained by hardware. The 64-bit physical memory
> address format is as follows:
> 
> 0x-0000-YZZZ-ZZZZ-ZZZZ
> 
> The high 16 bits should be 0, which means the real physical address
> supported by Loongson-3 is 48-bit. The "Y" bits is the base address of
> each node, which can be also considered as the node-id. The "Z" bits is
> the address offset within a node, which means every node has a 44 bits
> address space.
> 
> Macros XPHYSADDR and MAX_PHYSMEM_BITS are modified unconditionally,
> because many other MIPS CPUs have also extended their address spaces.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/include/asm/addrspace.h                  |    2 +-
>  arch/mips/include/asm/mach-loongson/boot_param.h   |    3 +
>  .../include/asm/mach-loongson/kernel-entry-init.h  |   52 ++++
>  arch/mips/include/asm/mach-loongson/mmzone.h       |   53 ++++
>  arch/mips/include/asm/mach-loongson/topology.h     |   23 ++
>  arch/mips/include/asm/sparsemem.h                  |    2 +-
>  arch/mips/kernel/setup.c                           |    2 +-
>  arch/mips/loongson/Kconfig                         |    1 +
>  arch/mips/loongson/common/env.c                    |    7 +
>  arch/mips/loongson/common/init.c                   |    4 +
>  arch/mips/loongson/loongson-3/Makefile             |    2 +
>  arch/mips/loongson/loongson-3/numa.c               |  291 ++++++++++++++++++++
>  arch/mips/loongson/loongson-3/smp.c                |    8 +-
>  13 files changed, 445 insertions(+), 5 deletions(-)
>  create mode 100644 arch/mips/include/asm/mach-loongson/kernel-entry-init.h
>  create mode 100644 arch/mips/include/asm/mach-loongson/mmzone.h
>  create mode 100644 arch/mips/include/asm/mach-loongson/topology.h
>  create mode 100644 arch/mips/loongson/loongson-3/numa.c
> 
> diff --git a/arch/mips/include/asm/addrspace.h b/arch/mips/include/asm/addrspace.h
> index 3f74545..3b0e51d 100644
> --- a/arch/mips/include/asm/addrspace.h
> +++ b/arch/mips/include/asm/addrspace.h
> @@ -52,7 +52,7 @@
>   */
>  #define CPHYSADDR(a)		((_ACAST32_(a)) & 0x1fffffff)
>  #define XPHYSADDR(a)		((_ACAST64_(a)) &			\
> -				 _CONST64_(0x000000ffffffffff))
> +				 _CONST64_(0x0000ffffffffffff))
>  
>  #ifdef CONFIG_64BIT
>  
> diff --git a/arch/mips/include/asm/mach-loongson/boot_param.h b/arch/mips/include/asm/mach-loongson/boot_param.h
> index 829a7ec..8b06c96 100644
> --- a/arch/mips/include/asm/mach-loongson/boot_param.h
> +++ b/arch/mips/include/asm/mach-loongson/boot_param.h
> @@ -146,6 +146,9 @@ struct boot_params {
>  
>  struct loongson_system_configuration {
>  	u32 nr_cpus;
> +	u32 nr_nodes;
> +	int cores_per_node;
> +	int cores_per_package;
>  	enum loongson_cpu_type cputype;
>  	u64 ht_control_base;
>  	u64 pci_mem_start_addr;
> diff --git a/arch/mips/include/asm/mach-loongson/kernel-entry-init.h b/arch/mips/include/asm/mach-loongson/kernel-entry-init.h
> new file mode 100644
> index 0000000..df5fca8
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-loongson/kernel-entry-init.h
> @@ -0,0 +1,52 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2005 Embedded Alley Solutions, Inc
> + * Copyright (C) 2005 Ralf Baechle (ralf@linux-mips.org)
> + * Copyright (C) 2009 Jiajie Chen (chenjiajie@cse.buaa.edu.cn)
> + * Copyright (C) 2012 Huacai Chen (chenhc@lemote.com)
> + */
> +#ifndef __ASM_MACH_LOONGSON_KERNEL_ENTRY_H
> +#define __ASM_MACH_LOONGSON_KERNEL_ENTRY_H
> +
> +/*
> + * Override macros used in arch/mips/kernel/head.S.
> + */
> +	.macro	kernel_entry_setup
> +#ifdef CONFIG_CPU_LOONGSON3
> +	.set	push
> +	.set	mips64
> +	/* Set LPA on LOONGSON3 config3 */
> +	mfc0	t0, $16, 3
> +	or	t0, (0x1 << 7)
> +	mtc0	t0, $16, 3
> +	/* Set ELPA on LOONGSON3 pagegrain */
> +	li	t0, (0x1 << 29)
> +	mtc0	t0, $5, 1
> +	_ehb
> +	.set	pop
> +#endif
> +	.endm
> +
> +/*
> + * Do SMP slave processor setup.
> + */
> +	.macro	smp_slave_setup
> +#ifdef CONFIG_CPU_LOONGSON3
> +	.set	push
> +	.set	mips64
> +	/* Set LPA on LOONGSON3 config3 */
> +	mfc0	t0, $16, 3
> +	or	t0, (0x1 << 7)
> +	mtc0	t0, $16, 3
> +	/* Set ELPA on LOONGSON3 pagegrain */
> +	li	t0, (0x1 << 29)
> +	mtc0	t0, $5, 1
> +	_ehb
> +	.set	pop
> +#endif
> +	.endm
> +
> +#endif /* __ASM_MACH_LOONGSON_KERNEL_ENTRY_H */
> diff --git a/arch/mips/include/asm/mach-loongson/mmzone.h b/arch/mips/include/asm/mach-loongson/mmzone.h
> new file mode 100644
> index 0000000..37c08a2
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-loongson/mmzone.h
> @@ -0,0 +1,53 @@
> +/*
> + * Copyright (C) 2010 Loongson Inc. & Lemote Inc. &
> + *                    Insititute of Computing Technology
> + * Author:  Xiang Gao, gaoxiang@ict.ac.cn
> + *          Huacai Chen, chenhc@lemote.com
> + *          Xiaofu Meng, Shuangshuang Zhang
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +#ifndef _ASM_MACH_MMZONE_H
> +#define _ASM_MACH_MMZONE_H
> +
> +#include <boot_param.h>
> +#define NODE_ADDRSPACE_SHIFT 44
> +#define NODE0_ADDRSPACE_OFFSET 0x000000000000UL
> +#define NODE1_ADDRSPACE_OFFSET 0x100000000000UL
> +#define NODE2_ADDRSPACE_OFFSET 0x200000000000UL
> +#define NODE3_ADDRSPACE_OFFSET 0x300000000000UL
> +
> +#define pa_to_nid(addr)  (((addr) & 0xf00000000000) >> NODE_ADDRSPACE_SHIFT)
> +
> +#define LEVELS_PER_SLICE 128
> +
> +struct slice_data {
> +	unsigned long irq_enable_mask[2];
> +	int level_to_irq[LEVELS_PER_SLICE];
> +};
> +
> +struct hub_data {
> +	cpumask_t	h_cpus;
> +	unsigned long slice_map;
> +	unsigned long irq_alloc_mask[2];
> +	struct slice_data slice[2];
> +};
> +
> +struct node_data {
> +	struct pglist_data pglist;
> +	struct hub_data hub;
> +	cpumask_t cpumask;
> +};
> +
> +extern struct node_data *__node_data[];
> +
> +#define NODE_DATA(n)		(&__node_data[(n)]->pglist)
> +#define hub_data(n)		(&__node_data[(n)]->hub)
> +
> +extern void setup_zero_pages(void);
> +extern void __init prom_init_numa_memory(void);
> +
> +#endif /* _ASM_MACH_MMZONE_H */
> diff --git a/arch/mips/include/asm/mach-loongson/topology.h b/arch/mips/include/asm/mach-loongson/topology.h
> new file mode 100644
> index 0000000..5598ba7
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-loongson/topology.h
> @@ -0,0 +1,23 @@
> +#ifndef _ASM_MACH_TOPOLOGY_H
> +#define _ASM_MACH_TOPOLOGY_H
> +
> +#ifdef CONFIG_NUMA
> +
> +#define cpu_to_node(cpu)	((cpu) >> 2)
> +#define parent_node(node)	(node)
> +#define cpumask_of_node(node)	(&__node_data[(node)]->cpumask)
> +
> +struct pci_bus;
> +extern int pcibus_to_node(struct pci_bus *);
> +
> +#define cpumask_of_pcibus(bus)	(cpu_online_mask)
> +
> +extern unsigned char __node_distances[MAX_NUMNODES][MAX_NUMNODES];
> +
> +#define node_distance(from, to)	(__node_distances[(from)][(to)])
> +
> +#endif
> +
> +#include <asm-generic/topology.h>
> +
> +#endif /* _ASM_MACH_TOPOLOGY_H */
> diff --git a/arch/mips/include/asm/sparsemem.h b/arch/mips/include/asm/sparsemem.h
> index d2da53c..b1071c1 100644
> --- a/arch/mips/include/asm/sparsemem.h
> +++ b/arch/mips/include/asm/sparsemem.h
> @@ -11,7 +11,7 @@
>  #else
>  # define SECTION_SIZE_BITS	28
>  #endif
> -#define MAX_PHYSMEM_BITS	35
> +#define MAX_PHYSMEM_BITS	48

this particular change has increased mem_section static array from 16k to 16M.
Or total .bss of the kernel from 700k to >16M (v4.4).

Logical solution would be to switch from SPARSEMEM_STATIC to SPARSEMEM_EXTREME,
but there is commit 7de58fab ("[MIPS] Sparsemem fixes"), which warns against it.

Do you have any idea, if the 11 years old warning is still actual?
Any better ideas to repair this waste of memory? 

>  
>  #endif /* CONFIG_SPARSEMEM */
>  #endif /* _MIPS_SPARSEMEM_H */
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 2f01201..7c1fe2b 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -282,7 +282,7 @@ static unsigned long __init init_initrd(void)
>   * Initialize the bootmem allocator. It also setup initrd related data
>   * if needed.
>   */
> -#ifdef CONFIG_SGI_IP27
> +#if defined(CONFIG_SGI_IP27) || (defined(CONFIG_CPU_LOONGSON3) && defined(CONFIG_NUMA))
>  
>  static void __init bootmem_init(void)
>  {
> diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
> index e6a86cc..a14a50d 100644
> --- a/arch/mips/loongson/Kconfig
> +++ b/arch/mips/loongson/Kconfig
> @@ -79,6 +79,7 @@ config LEMOTE_MACH3A
>  	select SYS_HAS_EARLY_PRINTK
>  	select SYS_SUPPORTS_SMP
>  	select SYS_SUPPORTS_HOTPLUG_CPU
> +	select SYS_SUPPORTS_NUMA
>  	select SYS_SUPPORTS_64BIT_KERNEL
>  	select SYS_SUPPORTS_HIGHMEM
>  	select SYS_SUPPORTS_LITTLE_ENDIAN
> diff --git a/arch/mips/loongson/common/env.c b/arch/mips/loongson/common/env.c
> index dc59241..33a13b9 100644
> --- a/arch/mips/loongson/common/env.c
> +++ b/arch/mips/loongson/common/env.c
> @@ -80,17 +80,24 @@ void __init prom_init_env(void)
>  	cpu_clock_freq = ecpu->cpu_clock_freq;
>  	loongson_sysconf.cputype = ecpu->cputype;
>  	if (ecpu->cputype == Loongson_3A) {
> +		loongson_sysconf.cores_per_node = 4;
> +		loongson_sysconf.cores_per_package = 4;
>  		loongson_chipcfg[0] = 0x900000001fe00180;
>  		loongson_chipcfg[1] = 0x900010001fe00180;
>  		loongson_chipcfg[2] = 0x900020001fe00180;
>  		loongson_chipcfg[3] = 0x900030001fe00180;
>  	} else {
> +		loongson_sysconf.cores_per_node = 1;
> +		loongson_sysconf.cores_per_package = 1;
>  		loongson_chipcfg[0] = 0x900000001fe00180;
>  	}
>  
>  	loongson_sysconf.nr_cpus = ecpu->nr_cpus;
>  	if (ecpu->nr_cpus > NR_CPUS || ecpu->nr_cpus == 0)
>  		loongson_sysconf.nr_cpus = NR_CPUS;
> +	loongson_sysconf.nr_nodes = (loongson_sysconf.nr_cpus +
> +		loongson_sysconf.cores_per_node - 1) /
> +		loongson_sysconf.cores_per_node;
>  
>  	loongson_sysconf.pci_mem_start_addr = eirq_source->pci_mem_start_addr;
>  	loongson_sysconf.pci_mem_end_addr = eirq_source->pci_mem_end_addr;
> diff --git a/arch/mips/loongson/common/init.c b/arch/mips/loongson/common/init.c
> index f37fe54..f6af3ab 100644
> --- a/arch/mips/loongson/common/init.c
> +++ b/arch/mips/loongson/common/init.c
> @@ -30,7 +30,11 @@ void __init prom_init(void)
>  	set_io_port_base((unsigned long)
>  		ioremap(LOONGSON_PCIIO_BASE, LOONGSON_PCIIO_SIZE));
>  
> +#ifdef CONFIG_NUMA
> +	prom_init_numa_memory();
> +#else
>  	prom_init_memory();
> +#endif
>  
>  	/*init the uart base address */
>  	prom_init_uart_base();
> diff --git a/arch/mips/loongson/loongson-3/Makefile b/arch/mips/loongson/loongson-3/Makefile
> index 70152b2..471b0f2a 100644
> --- a/arch/mips/loongson/loongson-3/Makefile
> +++ b/arch/mips/loongson/loongson-3/Makefile
> @@ -4,3 +4,5 @@
>  obj-y			+= irq.o
>  
>  obj-$(CONFIG_SMP)	+= smp.o
> +
> +obj-$(CONFIG_NUMA)	+= numa.o
> diff --git a/arch/mips/loongson/loongson-3/numa.c b/arch/mips/loongson/loongson-3/numa.c
> new file mode 100644
> index 0000000..ca025a6
> --- /dev/null
> +++ b/arch/mips/loongson/loongson-3/numa.c
> @@ -0,0 +1,291 @@
> +/*
> + * Copyright (C) 2010 Loongson Inc. & Lemote Inc. &
> + *                    Insititute of Computing Technology
> + * Author:  Xiang Gao, gaoxiang@ict.ac.cn
> + *          Huacai Chen, chenhc@lemote.com
> + *          Xiaofu Meng, Shuangshuang Zhang
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/mmzone.h>
> +#include <linux/module.h>
> +#include <linux/nodemask.h>
> +#include <linux/swap.h>
> +#include <linux/memblock.h>
> +#include <linux/bootmem.h>
> +#include <linux/pfn.h>
> +#include <linux/highmem.h>
> +#include <asm/page.h>
> +#include <asm/pgalloc.h>
> +#include <asm/sections.h>
> +#include <linux/bootmem.h>
> +#include <linux/init.h>
> +#include <linux/irq.h>
> +#include <asm/bootinfo.h>
> +#include <asm/mc146818-time.h>
> +#include <asm/time.h>
> +#include <asm/wbflush.h>
> +#include <boot_param.h>
> +
> +static struct node_data prealloc__node_data[MAX_NUMNODES];
> +unsigned char __node_distances[MAX_NUMNODES][MAX_NUMNODES];
> +struct node_data *__node_data[MAX_NUMNODES];
> +EXPORT_SYMBOL(__node_data);
> +
> +static void enable_lpa(void)
> +{
> +	unsigned long value;
> +
> +	value = __read_32bit_c0_register($16, 3);
> +	value |= 0x00000080;
> +	__write_32bit_c0_register($16, 3, value);
> +	value = __read_32bit_c0_register($16, 3);
> +	pr_info("CP0_Config3: CP0 16.3 (0x%lx)\n", value);
> +
> +	value = __read_32bit_c0_register($5, 1);
> +	value |= 0x20000000;
> +	__write_32bit_c0_register($5, 1, value);
> +	value = __read_32bit_c0_register($5, 1);
> +	pr_info("CP0_PageGrain: CP0 5.1 (0x%lx)\n", value);
> +}
> +
> +static void cpu_node_probe(void)
> +{
> +	int i;
> +
> +	nodes_clear(node_possible_map);
> +	nodes_clear(node_online_map);
> +	for (i = 0; i < loongson_sysconf.nr_nodes; i++) {
> +		node_set_state(num_online_nodes(), N_POSSIBLE);
> +		node_set_online(num_online_nodes());
> +	}
> +
> +	pr_info("NUMA: Discovered %d cpus on %d nodes\n",
> +		loongson_sysconf.nr_cpus, num_online_nodes());
> +}
> +
> +static int __init compute_node_distance(int row, int col)
> +{
> +	int package_row = row * loongson_sysconf.cores_per_node /
> +				loongson_sysconf.cores_per_package;
> +	int package_col = col * loongson_sysconf.cores_per_node /
> +				loongson_sysconf.cores_per_package;
> +
> +	if (col == row)
> +		return 0;
> +	else if (package_row == package_col)
> +		return 40;
> +	else
> +		return 100;
> +}
> +
> +static void __init init_topology_matrix(void)
> +{
> +	int row, col;
> +
> +	for (row = 0; row < MAX_NUMNODES; row++)
> +		for (col = 0; col < MAX_NUMNODES; col++)
> +			__node_distances[row][col] = -1;
> +
> +	for_each_online_node(row) {
> +		for_each_online_node(col) {
> +			__node_distances[row][col] =
> +				compute_node_distance(row, col);
> +		}
> +	}
> +}
> +
> +static unsigned long nid_to_addroffset(unsigned int nid)
> +{
> +	unsigned long result;
> +	switch (nid) {
> +	case 0:
> +	default:
> +		result = NODE0_ADDRSPACE_OFFSET;
> +		break;
> +	case 1:
> +		result = NODE1_ADDRSPACE_OFFSET;
> +		break;
> +	case 2:
> +		result = NODE2_ADDRSPACE_OFFSET;
> +		break;
> +	case 3:
> +		result = NODE3_ADDRSPACE_OFFSET;
> +		break;
> +	}
> +	return result;
> +}
> +
> +static void __init szmem(unsigned int node)
> +{
> +	u32 i, mem_type;
> +	static unsigned long num_physpages = 0;
> +	u64 node_id, node_psize, start_pfn, end_pfn, mem_start, mem_size;
> +
> +	/* Parse memory information and activate */
> +	for (i = 0; i < loongson_memmap->nr_map; i++) {
> +		node_id = loongson_memmap->map[i].node_id;
> +		if (node_id != node)
> +			continue;
> +
> +		mem_type = loongson_memmap->map[i].mem_type;
> +		mem_size = loongson_memmap->map[i].mem_size;
> +		mem_start = loongson_memmap->map[i].mem_start;
> +
> +		switch (mem_type) {
> +		case SYSTEM_RAM_LOW:
> +			start_pfn = ((node_id << 44) + mem_start) >> PAGE_SHIFT;
> +			node_psize = (mem_size << 20) >> PAGE_SHIFT;
> +			end_pfn  = start_pfn + node_psize;
> +			num_physpages += node_psize;
> +			pr_info("Node%d: mem_type:%d, mem_start:0x%llx, mem_size:0x%llx MB\n",
> +				(u32)node_id, mem_type, mem_start, mem_size);
> +			pr_info("       start_pfn:0x%llx, end_pfn:0x%llx, num_physpages:0x%lx\n",
> +				start_pfn, end_pfn, num_physpages);
> +			add_memory_region((node_id << 44) + mem_start,
> +				(u64)mem_size << 20, BOOT_MEM_RAM);
> +			memblock_add_node(PFN_PHYS(start_pfn),
> +				PFN_PHYS(end_pfn - start_pfn), node);
> +			break;
> +		case SYSTEM_RAM_HIGH:
> +			start_pfn = ((node_id << 44) + mem_start) >> PAGE_SHIFT;
> +			node_psize = (mem_size << 20) >> PAGE_SHIFT;
> +			end_pfn  = start_pfn + node_psize;
> +			num_physpages += node_psize;
> +			pr_info("Node%d: mem_type:%d, mem_start:0x%llx, mem_size:0x%llx MB\n",
> +				(u32)node_id, mem_type, mem_start, mem_size);
> +			pr_info("       start_pfn:0x%llx, end_pfn:0x%llx, num_physpages:0x%lx\n",
> +				start_pfn, end_pfn, num_physpages);
> +			add_memory_region((node_id << 44) + mem_start,
> +				(u64)mem_size << 20, BOOT_MEM_RAM);
> +			memblock_add_node(PFN_PHYS(start_pfn),
> +				PFN_PHYS(end_pfn - start_pfn), node);
> +			break;
> +		case MEM_RESERVED:
> +			pr_info("Node%d: mem_type:%d, mem_start:0x%llx, mem_size:0x%llx MB\n",
> +				(u32)node_id, mem_type, mem_start, mem_size);
> +			add_memory_region((node_id << 44) + mem_start,
> +				(u64)mem_size << 20, BOOT_MEM_RESERVED);
> +			memblock_reserve(((node_id << 44) + mem_start),
> +				mem_size << 20);
> +			break;
> +		}
> +	}
> +}
> +
> +static void __init node_mem_init(unsigned int node)
> +{
> +	unsigned long bootmap_size;
> +	unsigned long node_addrspace_offset;
> +	unsigned long start_pfn, end_pfn, freepfn;
> +
> +	node_addrspace_offset = nid_to_addroffset(node);
> +	pr_info("Node%d's addrspace_offset is 0x%lx\n",
> +			node, node_addrspace_offset);
> +
> +	get_pfn_range_for_nid(node, &start_pfn, &end_pfn);
> +	freepfn = start_pfn;
> +	if (node == 0)
> +		freepfn = PFN_UP(__pa_symbol(&_end)); /* kernel end address */
> +	pr_info("Node%d: start_pfn=0x%lx, end_pfn=0x%lx, freepfn=0x%lx\n",
> +		node, start_pfn, end_pfn, freepfn);
> +
> +	__node_data[node] = prealloc__node_data + node;
> +
> +	NODE_DATA(node)->bdata = &bootmem_node_data[node];
> +	NODE_DATA(node)->node_start_pfn = start_pfn;
> +	NODE_DATA(node)->node_spanned_pages = end_pfn - start_pfn;
> +
> +	bootmap_size = init_bootmem_node(NODE_DATA(node), freepfn,
> +					start_pfn, end_pfn);
> +	free_bootmem_with_active_regions(node, end_pfn);
> +	if (node == 0) /* used by finalize_initrd() */
> +		max_low_pfn = end_pfn;
> +
> +	/* This is reserved for the kernel and bdata->node_bootmem_map */
> +	reserve_bootmem_node(NODE_DATA(node), start_pfn << PAGE_SHIFT,
> +		((freepfn - start_pfn) << PAGE_SHIFT) + bootmap_size,
> +		BOOTMEM_DEFAULT);
> +
> +	if (node == 0 && node_end_pfn(0) >= (0xffffffff >> PAGE_SHIFT)) {
> +		/* Reserve 0xff800000~0xffffffff for RS780E integrated GPU */
> +		reserve_bootmem_node(NODE_DATA(node),
> +				(node_addrspace_offset | 0xff800000),
> +				8 << 20, BOOTMEM_DEFAULT);
> +	}
> +
> +	sparse_memory_present_with_active_regions(node);
> +}
> +
> +static __init void prom_meminit(void)
> +{
> +	unsigned int node, cpu;
> +
> +	cpu_node_probe();
> +	init_topology_matrix();
> +
> +	for (node = 0; node < loongson_sysconf.nr_nodes; node++) {
> +		if (node_online(node)) {
> +			szmem(node);
> +			node_mem_init(node);
> +			cpus_clear(__node_data[(node)]->cpumask);
> +		}
> +	}
> +	for (cpu = 0; cpu < loongson_sysconf.nr_cpus; cpu++) {
> +		node = cpu / loongson_sysconf.cores_per_node;
> +		if (node >= num_online_nodes())
> +			node = 0;
> +		pr_info("NUMA: set cpumask cpu %d on node %d\n", cpu, node);
> +		cpu_set(cpu, __node_data[(node)]->cpumask);
> +	}
> +}
> +
> +void __init paging_init(void)
> +{
> +	unsigned node;
> +	unsigned long zones_size[MAX_NR_ZONES] = {0, };
> +
> +	pagetable_init();
> +
> +	for_each_online_node(node) {
> +		unsigned long  start_pfn, end_pfn;
> +
> +		get_pfn_range_for_nid(node, &start_pfn, &end_pfn);
> +
> +		if (end_pfn > max_low_pfn)
> +			max_low_pfn = end_pfn;
> +	}
> +#ifdef CONFIG_ZONE_DMA32
> +	zones_size[ZONE_DMA32] = MAX_DMA32_PFN;
> +#endif
> +	zones_size[ZONE_NORMAL] = max_low_pfn;
> +	free_area_init_nodes(zones_size);
> +}
> +
> +void __init mem_init(void)
> +{
> +	high_memory = (void *) __va(get_num_physpages() << PAGE_SHIFT);
> +	free_all_bootmem();
> +	setup_zero_pages();	/* This comes from node 0 */
> +	mem_init_print_info(NULL);
> +}
> +
> +/* All PCI device belongs to logical Node-0 */
> +int pcibus_to_node(struct pci_bus *bus)
> +{
> +	return 0;
> +}
> +EXPORT_SYMBOL(pcibus_to_node);
> +
> +void __init prom_init_numa_memory(void)
> +{
> +	enable_lpa();
> +	prom_meminit();
> +}
> +EXPORT_SYMBOL(prom_init_numa_memory);
> diff --git a/arch/mips/loongson/loongson-3/smp.c b/arch/mips/loongson/loongson-3/smp.c
> index 3c320e7..ed0e2d0 100644
> --- a/arch/mips/loongson/loongson-3/smp.c
> +++ b/arch/mips/loongson/loongson-3/smp.c
> @@ -203,6 +203,8 @@ static void loongson3_init_secondary(void)
>  	for (i = 0; i < loongson_sysconf.nr_cpus; i++)
>  		loongson3_ipi_write32(0xffffffff, ipi_en0_regs[i]);
>  
> +	cpu_data[cpu].package = cpu / loongson_sysconf.cores_per_package;
> +	cpu_data[cpu].core = cpu % loongson_sysconf.cores_per_package;
>  	per_cpu(cpu_state, cpu) = CPU_ONLINE;
>  
>  	i = 0;
> @@ -394,17 +396,19 @@ static int loongson3_cpu_callback(struct notifier_block *nfb,
>  	unsigned long action, void *hcpu)
>  {
>  	unsigned int cpu = (unsigned long)hcpu;
> +	uint64_t core_id = cpu_data[cpu].core;
> +	uint64_t package_id = cpu_data[cpu].package;
>  
>  	switch (action) {
>  	case CPU_POST_DEAD:
>  	case CPU_POST_DEAD_FROZEN:
>  		pr_info("Disable clock for CPU#%d\n", cpu);
> -		LOONGSON_CHIPCFG(0) &= ~(1 << (12 + cpu));
> +		LOONGSON_CHIPCFG(package_id) &= ~(1 << (12 + core_id));
>  		break;
>  	case CPU_UP_PREPARE:
>  	case CPU_UP_PREPARE_FROZEN:
>  		pr_info("Enable clock for CPU#%d\n", cpu);
> -		LOONGSON_CHIPCFG(0) |= 1 << (12 + cpu);
> +		LOONGSON_CHIPCFG(package_id) |= 1 << (12 + core_id);
>  		break;
>  	}
>  
> 

-- 
Best regards,
Alexander Sverdlin.
