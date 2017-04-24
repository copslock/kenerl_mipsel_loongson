Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Apr 2017 23:19:58 +0200 (CEST)
Received: from mail-sn1nam01on0084.outbound.protection.outlook.com ([104.47.32.84]:3550
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993904AbdDXVTsB3e0m (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Apr 2017 23:19:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fHOYr8+GwNfDWa8WdW3jfyfcxHK+KooS+YUh3ggNPNE=;
 b=Usk+roMRLuwm+5nk9az8qWSCebcEpO3aHFNEQNORNZ/nvP2iRUmjVg4k//iCzNZlqEgOc80paqLPsSWAEkQL9a2L0mcSICycMUcUywBQwemD8VYOIJuRfoQ9LbF728JFpv9xbIzZjRlByA/Ddp91xgR6zMu7FzrE+p6oLlUru38=
Authentication-Results: linux-mips.org; dkim=none (message not signed)
 header.d=none;linux-mips.org; dmarc=none action=none header.from=cavium.com;
Received: from [10.0.0.4] (50.82.184.123) by
 CY4PR07MB3208.namprd07.prod.outlook.com (10.172.115.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1047.13; Mon, 24 Apr 2017 21:19:39 +0000
Subject: Re: [PATCH 0/4] MMC support for Octeon platforms.
To:     Ulf Hansson <ulf.hansson@linaro.org>
References: <1493059318-767-1-git-send-email-steven.hill@cavium.com>
 <CAPDyKFoAeyqnomWSphRt95WPDuhHRnAuowYHRnMkAB6izZv4nw@mail.gmail.com>
Cc:     David Daney <david.daney@cavium.com>,
        Jan Glauber <jglauber@cavium.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <6576c581-b575-db7f-f9b3-4aabdef9e59b@cavium.com>
Date:   Mon, 24 Apr 2017 16:19:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoAeyqnomWSphRt95WPDuhHRnAuowYHRnMkAB6izZv4nw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.82.184.123]
X-ClientProxiedBy: MWHPR1601CA0001.namprd16.prod.outlook.com (10.172.93.11) To
 CY4PR07MB3208.namprd07.prod.outlook.com (10.172.115.150)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa82406a-9edc-4155-2276-08d48b579f31
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:CY4PR07MB3208;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3208;3:vWFYdbwrWAIMahAMd6T5vosogTqQ29Q6fp1umaYuHTvyzsW+w3FPcgI4obSq2/pGKaA8I9c6sLs9LjHYo5ED6euwQ1VFlWN2FNmF+SFskDxTwhLWLqxxZ+TTP/7CEnxRVix+tF7tjB7ldCe5QksnFZ/RD9yhJjoPcO9i7seBhp9Rt56ZwZvHkrGRMmJWrQSsfxAzn/S+UlzkRCVswTDuLnNadT8TERpsSn5P8iCVgaPIh0C0152OLXdW0BBqxspgXzWQnmnBNAmWy3wJUPcXwnEreSdKuMYXof2P8vBg5eG3PRhB24PLDalsNPixJUnc82tSIb++pYa6JPn8nmgD7g==;25:mx35jaWJsRpJ4MkxJc+ZlXKemoutHoucoQuxMOvUWcTMkcybh7jF+ryZNMaO9QNgR1CYbAzVv0jBWZWIc0bGf+0av3m+MLpZhBDicpO+1gup9S67IZwh+nwXj6+6Jg7APl70t7TWsC+kBGzltUQyG347+f8tAQjYiZ2pwLM1q7hCsT85gyPI0V940vM8ZuTT9LSn4aEusk6gBwPoiZ5Z6Q2SU6k1Tw2AuD4ZB7f6UEELedEFjCpFY4elN09mq7/Kn8vb44Yb9RB8zAKK6Yl0QAYW1GZ/33w4FMQx9V+oldXsevrVL/lCq8ncj8e+nIcX+/1C9IJkMIxXE/olCBeScE4G4Y1LgRTfWfbHrFSzZVj6Ek1FMleZteHfHppEhPLMjZMnFPCr4gnyEM24l0aohcaFsvbxLsirr0jL0rifETgvhj7nhXUU4aNsi9MX5J2zfpO4f/DiVxVrWBfsQeooUQ==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3208;31:eYqL/j7BNKGfCUeq/DPL1SKOHnkp47w8ZUhfjEWlLxO1/CBisr55QGzu3mI6X3k1VwYsj1SKanzIfIyVXDQKnZQ0c8PKgPYN3sGfFMGGL8WVWMy6QOfy8Wq8QY5p/mvpC+tgIk9Fnd2HBiBIjUij6DGXul6rZ7z0jVTrlYMs1/daGpAjZKIbi/mlA+b9LxmwkNnos/yPhhnMQXTs6YFM3RpNyCpuItasdfZD+1/prrO0ibrgfHet7i3vgb1Lmh3J;20:jsQUUlWaI152qg06BYDMmdzD/84f+eG4xHtbFqNztnAlfXFzFTPDPtuDOAwwpKH00sBm2dMIs6HgobFeYccUawZcl/Xm2Qr0kCJyIW8RDwbn8TfGkYvmXBe1RThoQHZHq6lkJwoXL+bsZy6nIaC6v96yFIHlez8fgmmMz7vrq8se3rvcF82jr6A4ZXeq41V4Wi3l20SBd/JJz7ljEaJotDy6gHkYFXUJ7BrWivOH07iHzf4i9dsjYBkn3YYX3zFxUwKlNd6KEwEiRP1kY3AF2zOylJtXv3jWk1xGCK2eJStH6gTybCpD2YnAtMigedP0SfmZPbtfOZptB+/PypXdhotIyOAjcHvFfOQr5i0zp7jGAkyBAtSrUiIjKx5Nqw+B4Vkq66UMDyzwap2N64h+OUfLjg1sX0WuEn2O43EP3LE9IQddfZvYQoartSW8VFLyamBHSSmCILXJVa9yIsowMc/wwMsRHqQjXDX4Mi8h5fxKTdrQdwYnZBcBU+mEanKU
X-Microsoft-Antispam-PRVS: <CY4PR07MB32086D352EA34C85AE818831801F0@CY4PR07MB3208.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(6041248)(201703131423075)(201702281528075)(201703061421075)(20161123560025)(20161123562025)(20161123555025)(20161123564025)(6072148);SRVR:CY4PR07MB3208;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3208;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3208;4:G/CxULgNA9NGJ8gcq8H0l1fueVs9OHc0slmULaVcuiM3i+pSLTPWjq5CQBJlfLSBv7XS65QZK2ofVwOdF9jy44rE7DosMvqkDCj0Y5+0QY2O7krDYCxf7GKF/XIBgvfnyZSK0L6ymmGX4oUct7ly0oKBnQG3slfxCLqlgWFGJCdH+Udfx9Rkjd1rzNchcoglHYDYQ80FxbwNfmSHeLS5yxi/bPsIRrzFkHCdKhpe3oRXxUBzrwBahhZQW4GiNVz5rBmfO0bYcDuiDqWu0jT/BBtorGDHFRkJVB6pIX7mrZDVKLpscAt7KBz69nZGDyfVUBGEsfjIvnTrx3RmQtrw1JhJfaJcwATr6dO/Vnhct+69p6UcMMIWUJzEIk28T0FVKfgftdvKomR+BT4bDwdztwMcxmLfCKjJderUjXR0hDub8SfxI8eTOTUcj7KNWcWfOqBIklzQ9kHuGSIzocYGUUl2OHTmKG/TjbLUEe6ZmaHO32RJCb0vB8eG6/iHop+xpYqG3rEAHMV7rA6MxqER+rNFglyctAmD78V9HR/khq0Ufh54x+ipINO2m+Co4I/xzCwWjLaWRAvlBjW2JNHCOAjaOFAgzoFPmKitXje/N7wFo82YG/jYwBisW8HqtL8iiWINeZ33/CFraxaBgvudcwJ3QZXVf260upGguO7Oc0LF/WLvx22KDS5GxHlep/c//Larvrr8FbiEjjxLhVWojw==
X-Forefront-PRVS: 0287BBA78D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6049001)(6009001)(39840400002)(39400400002)(39410400002)(39850400002)(24454002)(377454003)(77096006)(6486002)(6666003)(66066001)(36756003)(31686004)(189998001)(33646002)(42186005)(2950100002)(2906002)(6916009)(83506001)(4326008)(305945005)(8676002)(25786009)(558084003)(6116002)(6246003)(3846002)(7736002)(53546009)(53936002)(81166006)(50466002)(4001350100001)(38730400002)(76176999)(50986999)(54356999)(54906002)(110136004)(64126003)(23676002)(86362001)(229853002)(230700001)(47776003)(5660300001)(65956001)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3208;H:[10.0.0.4];FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzMjA4OzIzOjhVcDhXaHE0TmlSeExGTG0waHoxWExad2o2?=
 =?utf-8?B?Zk5ETHhLS3RxMy9YV2xEb2R6YUNHTnhEYW5xaUkzVEpPRWkyendURTFxKzQ0?=
 =?utf-8?B?dXczTkJ1bThBVnp4YUM2R3dackM0bk96cmltMDFJNEExeUpTdXVMOUhWMkl2?=
 =?utf-8?B?K1VCYjIzYUppREhGRWdLUUZiM25rdmhrb3Y4SkNmTEYxUlMvQ2k2bXgxOXBo?=
 =?utf-8?B?bWZmTjZvbFV6cUFVVjdZZ2l0WFQvWkpZTzVLOUI3ZnAyR1hGeldPcUxWYk1Y?=
 =?utf-8?B?WnNQRjRySkcvSUZsT1lrSm1OVVRCanpMa1NmallrQzFJYVJEMVViT1ErdkpW?=
 =?utf-8?B?RkVSVTNEOEpPa21ZRnlUeVBWVzZRQ0Z6MVdMYWtOSXZ3amt5Q1FrL2NKNUhq?=
 =?utf-8?B?OWYvbWtnQTJEYVdsam5nWDFTdUV3YzZ0UmpnZVJPZ0NUZFUvaVJrTU1WVmIv?=
 =?utf-8?B?Zlp5MmVZaTJlVFZ6M1NQa1dCT3VZWFlyL0xHU3hPWTlUSXkxUzRZYXBLVmIv?=
 =?utf-8?B?MFdGY2dkV0RzZ0h4bHB4MXdLZUJlUDZUVUwvZmpqUEc4aFdsNm1UL3VwVHN6?=
 =?utf-8?B?ZUNXWk5oYWx0RjJSODhvNndROFN1Z3JxSnhGR1IrQzh3YTRxNkJ0MUdZSnMy?=
 =?utf-8?B?NHgzU3dnalY2LzVibFFHTXhtTks1ZU1ic0N5VEszVll2eEVGSzVQWW93alNp?=
 =?utf-8?B?ZjlRc0RBTnk0SDcxSXBGV0tGV2VURGFOdjlpRkJ2Zy80MEt2cCtxYTFwSGJD?=
 =?utf-8?B?Z0treFJCM1MwVWtQd3NhRCtLUGJDVlQyenVZYXhKRTJVbU9EbUtOZnd1YTNa?=
 =?utf-8?B?ZFp6VENobzBjSTEra1UyOVBFcUE3cG5Kd2o2VUptQ01oa3MyZUdVRS9CQ0hq?=
 =?utf-8?B?bEFMZUl4Rk1kSk5qR1Z2QXZiQUlUKzJleVF1QzFROEtrbUtMQU5NQk1pdW91?=
 =?utf-8?B?d2NXY1lMc3N3b09oOU5NRVYxWmxYc28xbGY0UVdxRHNiM0hzWFNqU2w3K2dp?=
 =?utf-8?B?c1RLckNTYWV1aWhSZStOT0ZKTnEzTWZvVHhRZ0htbFJEVVpaSjJ0Y0Y4UWNK?=
 =?utf-8?B?aU0xU01GbGUxdTkyYTJIREdqZGM4cGRCNGR4UHVqd3dUWnlMakE1WmNLcktV?=
 =?utf-8?B?eDhLWE1TTUZMQ2d3S1JZZE5Sak1yMzJUK3B6TFB1K3AxSEpiWXdmbXMyam1w?=
 =?utf-8?B?cTVxWGdGRVZNNnptQklaVTQzbGFlQ1kwMWt6UFRUZEg0QTN3THZ3MzFGNUxP?=
 =?utf-8?B?RW1yVG1mMHdNKytoYWx1VTBXdlVzNS9tb1d4cFl2bjloRjh1VEwxTEtUbmJV?=
 =?utf-8?B?a1k0R3c3NTlxR1c1Ty9CR1FKVDFhWVY2SXI0VUx1NWdUbUVRbi9OOFA0c0tC?=
 =?utf-8?B?aGVHcTZnMDliYThYbjN4MVo0ZTBFMEJGVkxSdTQ3YkVtR3ZIdU5tY1lSSm5U?=
 =?utf-8?B?VXRyT2lsTmVseWkycE1zdnJBTGo0WHlCSSt0UXROazVSMnFCQWpDckpaakFr?=
 =?utf-8?B?NVZLWS9WbTY1WlllbUF5R0pnZk4xUGZja0poUEpqOTh2MGpjSFgwbVZxUERx?=
 =?utf-8?B?UHVBSDlnUm1OMGx3T1dySEFFaWVrRnpLREJFckdGQkIwY3dXR0Vuc2lrUGhX?=
 =?utf-8?B?dHNvVlVwMzQyYXZXTy9CRm9yaDU5dlQ0TnFDaUxoUzd6UVJDaUxwZ2tNT3FI?=
 =?utf-8?Q?WYxZvCjY5Sw5kQaN7Z5YJ0Mmvj3uo0xxu48Ai1X?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3208;6:HZiBrCsP5qKbEMX9opf3+30Uj8leAqWCWJxHno6vSJ+l7XfxXuRp+ICUOt/VGP70Qs14Tsui9DOxXovbXN3193VX56TLK094pMGv6G1Tsvx+x78kfnalYAPxl156badUPgWhEz/Bl1NiYWdUo2dYRkhg6Gt8rDTRCtkrp7lZ41PLv2m8xv507fPgU9n9GP1/uMCo2D83/enLCJ8j5af7h63NjvX2QjrUzsikl2dCsbtuGp7QadULVIYAhkGZoMqG/YcEk0IjHIAesfNlQLv4VB4G8p+df1LGS1foI6JkBU1/E/EPihSrAp+X8FrY5JUttqCMEqSM23iGTRiSAAPBjzy2HNyx/KLAd/TvNb/k5+AxFohdKxoFbLBrTk8ocv12NbzclwJgaSDMEEGsZwIRpFZLdyDtX5Q+0twN49E1GV+U3if8Pk0dKqyLS3+vDmhYYee/pLXpa44+qB7BgSqmKdDOLXEs1bq2Ic2g8ErX/BkiIR7xpNMZ7UL5HTJvvbIhCnP3KCLQTcvAMq7qPXzxKQ==;5:3GifXRIjMzayJFrJU2kboVezEQMgEFYrx/Kl45LUj0UqDWu4p1bLwUOh9uvemZVod53g0GSAlHyYrzADEHG7oujJSbaQ8k+IHFXjhtAq4OrR9yTEuKZ4HD/N9aANf1HKJRo9W8pj5awMYkclr9nR2w==;24:lt/UcQPDVzXfFjLM5O7efuHd4YVx6McPwfrALC9w7GVsif1Npa2aik881cWcehl/fD7WwCjs+kGygRBV3n9KYUqyOi3jQMpMcj4UvTuraw0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3208;7:4PaS5sgBelB42D0ZFyOinrEup+LkRYiDwltQv0HT8m53y/oxHcfMFyHDD4lvjgb1mVjMlA5Hz28bRzMK21m/rDD4jNHOV8tDQEPw03QYDagbmTNeUo5TbqfH1mUZhPRzBNCHCVkzSrkpKk+TfAUaFHN5A5oAhsxzC6IZcy74D6+nd2ggAGuW8Lj1jN7CkBW9g6bBf0VegLZDUgn4gxlOw3BaqqubPpZSF2a9WVKeArs6rhrGpzRERBpl83v/XDZs7KQwBRfEHmx36bjYu7PK+1PId3qmqMGrKfY7ZdhFkJidghDuDwiYV5Pd2RFSZRtNvUe1FMU/ViByOA9P51RsWQ==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2017 21:19:39.9872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3208
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@cavium.com
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

On 04/24/2017 02:56 PM, Ulf Hansson wrote:

[....]
> 
> Thanks, applied patch 1->3. Patch 4 is for the MIPS SoC maintainer,
> unless I get an ack for it.
> 
Thanks Uffe.

Ralf, please take patch 4/4 into your -next branch. Cheers.


-Steve
