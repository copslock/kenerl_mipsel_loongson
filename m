Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Nov 2016 20:10:48 +0100 (CET)
Received: from mail-cys01nam02on0086.outbound.protection.outlook.com ([104.47.37.86]:4352
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992991AbcK2TKlhE9Lq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Nov 2016 20:10:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=E8mEg2/qPTJ9L8VZsNYolkNthnQ8foV6EWFhzbjky1k=;
 b=FtwaBfotyd/Xlbf5Ot0hWhtArvU4NFoIRT8FGhdvIQYDcjPePxuoxCIfox8+4RgAt0JQk7pVdaahvrvS2QSPfK0HjQMdd2IWVlBC6/NCOQlRDT8Mfil+WxYsISNEmiv1ctdA8xlNkDOmHHUoZ3exkY6ZCmEKepwBzZeIKsgVvvE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.22.239.243) by
 CY4PR07MB3205.namprd07.prod.outlook.com (10.172.115.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.747.13; Tue, 29 Nov 2016 19:10:34 +0000
Subject: Re: [PATCH v2 0/3] i2c: octeon: thunder: Fix i2c not working on
 Octeon
To:     Wolfram Sang <wsa-dev@sang-engineering.com>
References: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
 <99500824-4c63-b769-ad66-c136529b14b2@cavium.com>
 <20161122120106.GB3993@katana> <20161122145539.GA7716@hardcore>
 <20161128142208.GA3916@katana> <20161129091928.GB29487@hardcore>
 <52c6e31e-9351-fa26-aefe-4f1415324adf@cavium.com>
 <20161129183707.GA3378@katana>
CC:     Jan Glauber <jan.glauber@caviumnetworks.com>,
        Wolfram Sang <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        <linux-mips@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <6237fab7-fc5f-90fd-a652-b304f2a21a43@cavium.com>
Date:   Tue, 29 Nov 2016 13:10:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161129183707.GA3378@katana>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: DM3PR12CA0008.namprd12.prod.outlook.com (10.164.12.146) To
 CY4PR07MB3205.namprd07.prod.outlook.com (10.172.115.147)
X-MS-Office365-Filtering-Correlation-Id: a02b6ca4-9ea6-4909-7f8e-08d4188b657b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:CY4PR07MB3205;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3205;3:N9Pfvbt0E+6bXhP5pvnSJdjVfd25fnLhjpsVA0KuQFtrAEHZYPH1VJVqEyqrYwbUXS+rV5+W0AsLcCxcp7TiS+6fk0voaDiY4m6XL1G4dJ35uvJN2rx8hmy7SBOOKBEXFrZI1G6IJImTboZ5RdSJykReeXhn6AvKa8Een+WOpfYYHmJeadgjOLFhLtFPuZU7WL/1mYyvR/Av3LAsHDiS3mQUb7dlY/amXjGuszlJXMWC9L92JLpYGx5+3IFIKW5i0yxg2E+grTYjOBM+6+TSiQ==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3205;25:dYAIB92Q4qlHUNfl+xRDgdknnJ4bqSd1LyJygpnNkcaVqofU68BAzEkbx0pCRfbwnWTTKZ3/tzyZ96dIWuw6uHOuNbdHpyBxBvyoOrPICdFvyfz1fMuG0QvDZWkZUX14rVI3EJYtpdcUVfRo3ezez0p4m6VwwpiGfB96qmFHwLf/sa3m+7cgGOXsJLSpsVP+/OMKCjM23auZYdncG2MQiyqDIykWv8ARavYWdS0zKwzJJ2SB6lJa70MRDDMmPQhd6CXoV9UHniW3Ij8F79NRyZqsBPiNuh5H0erjGJeG3ddrsw+htNtsopmAV9kweb2hjcM0ybYmAz4+ghNw8EpBuLYUXUXtpfVPXKGIUo1P3hiaDSqGFzsaBjtw4Y9lT2lUUyfuqiYZCAqnsvJBHd0cKlIaMwqlYqeBc7sEuR30tz/IAo1YWw2oujMiZffHd0lh05zBFQw37RnjQUwUIn/6RWynOhRV60jSZHMeQ2QzwbO8f1h8gdXvFaEoZX60iUo3KEe11GeqCFCcJwMjZEJ8ugI2SFlX4O5oF5LAyamMHE3lHBdc1UMRIXI10fVAZ160JdRIMMHTUlPpSHljxgqCSz9TnjtrxA6hGl8frT7fH3hOuFVHGMxTvqAQYOaWHssAN2VfNcOhZk84XK8H7lnWsigBW5eAJTAlpegJYwKWLhdi1zdoYbTWiJ9u6NYpXI03pNR80HcUb4+yFvOeWUqH/pS74GyZbgh0do7kpX+m/TWgNnK2+/Z82Sy2vCnTh28ZcovqgAVMBRrs1ztHngZZtA==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3205;31:wLK0haYQ7R+Jq6zX5GpZaHQtzy6i7LDM81eI65Vf/suW6h8M83fu9FZ+OD6Nft0K5o+7d3qKMDmU7nW+qVLuEdUO61Bxff+XLiQMXUyF66PcmN4KOplaBXZNAQaItOCzneA4mqSAZxQ8U87u+zZikr38zzZuOZBbba9F6dr1qGavyvuc4yrW5E2JRZ36PzT4eDMEoxrTHaC4g0ko/BcJHRM6DEbxCUD3J25WO2AouQeX8XiIF88DE/S2pIoODWMKK36nUBds0JV3MrY3QTar7SBvNDG2t5cDMq8mPIf4/9Y=;20:/K9zGAfLcadUnEpxyF2wSC8krDuomFmvJl5IS1ZCbOwm0GnfWqO3FOdglLZVuPgJRHkZ6+7PPIPylCSBcaye/uUTPu2ILD5G7XIjn3ZMqLI/hfnCNCEuwsXqZ+vHfnWykoUox25s/ucgJ6kmk6QNKtMw/uIq8m5nd43fFJmqTti0ZZL/2PyT002PMd+IM9cwMn3iMQiGfJd6OfSm99RjJoIEfL/xYJUmvcD72urCZ9u++JZAF97M1DqvhQVemb+HYeYtXwpp+zYS9jNUf64fVRLxUdZlVdEVE3rWyiwAoh6/G6PuIzO8hc1797ARmnAAymmuXl5m0MDQxrHzg3fZ84/KTRH6a+KFHWoK7vMIFkmSf+SBifDOd4/LwLcloCM475W6kKri7VoLusTe4P4b1WvrC3v/KdBOqmVXiPdEngdP7lV8ydXy3cAy+AsYn3I7lAw8E2it6yd3nx8xBcNW9L3iTBmt92NSsUmJQLgxNWEIhqsn2Hr7Lz3JYYLOUYUG
X-Microsoft-Antispam-PRVS: <CY4PR07MB3205D356B4CAAA93AB2F3676808D0@CY4PR07MB3205.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6060326)(6040361)(6045199)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6061324)(6041248)(20161123555025)(20161123564025)(20161123560025)(20161123558021)(20161123562025);SRVR:CY4PR07MB3205;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3205;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3205;4:YXIERQX0V1TH+R3478qeeyn5qniNnsTQ1Wkqpc7Or62QuaPUuv3/fJAolR/SrAIBYKtoCymoIo7tLoF2oeLVAcePLuqyj1UFjNbw84aoiAqs1Oz3QI/cyLWsG4eYN65IQMarSbxpXot9jJ+YPyjJFuzm4gFeYstqO/sAHnPDZ+ek4j+aU+9NGKcyI1DAtu15e5vj8LDWzELPl9PbGluAiuJXumYcJn1Ye/U+KrRNe9VeAKuI2MAVXIhUfBrRpTV+I/9zfbaTrDYzgN9bKUlNwnxOBDXHaIWg3qHJYPMeikoQ8bziwPZeaqQim0r9s/9PVOluit3fnaLTtPjuoMriimcyfnWOJhVrsUJHGVRc24sb7xyuS1DadK/4L66loCmb680D5dRdbUzWZyM7YzweKLEed+yT1HMmRN28q4fsL22yPzY9AdEAImCUUCTdVG1HTD8Dgd1Vn9DhMein5RVPnHJzsUxLvMYhxfljT3YVld/j916C0qWZMcqub5WnSwaycQbW2u4+aVUZpl5ibktCt6GoCb7cLzpk7fSoAOJvuBSE5osRiSrgukowz5JGnoVK3AnWI4aVqfLvO1P0k3k+GBCSWaeseqXQInzxkntJmkxzXdn5UGXZtJckBvWl5YaXLZGd+B8ILjBv1/lsHHc64Q==
X-Forefront-PRVS: 01415BB535
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6049001)(6009001)(7916002)(199003)(189002)(24454002)(377454003)(77096006)(66066001)(733004)(81166006)(81156014)(39450400002)(39400400001)(6486002)(39380400001)(39410400001)(105586002)(106356001)(305945005)(3846002)(6116002)(7846002)(76176999)(101416001)(50986999)(54356999)(8676002)(64126003)(38730400001)(229853002)(42186005)(7736002)(23746002)(31686004)(50466002)(97736004)(65956001)(4001350100001)(107886002)(189998001)(110136003)(86362001)(68736007)(93886004)(4001430100002)(31696002)(65806001)(33646002)(230700001)(83506001)(6666003)(2906002)(2950100002)(6916009)(92566002)(36756003)(65826007)(5660300001)(47776003)(4326007);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3205;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;CY4PR07MB3205;23:lv3bH4HGlfCZoXMvfLuVKphjSse8lixiHeDjj?=
 =?Windows-1252?Q?HtZt+s2hOWEIPqI+hn0MCXmBu17hWoGKsfjmyVYRwLbgKD1COH1IL8TZ?=
 =?Windows-1252?Q?uybwg9ff3xhjZuVIb3eUEDPEHpod8zRT+fEMTVvJ26E5tvKfP9URy0D9?=
 =?Windows-1252?Q?atSY5kYumcBsvbeD7n6WGa3PKaDOCplCnV7v/crKdGBiwhoKotIqq7d0?=
 =?Windows-1252?Q?33WT8yN4L/I0ptF69Z7WejzvSd385kp+XQgHIt0s97GlZHC/Kz8J04Wf?=
 =?Windows-1252?Q?xDWx1NvnmY9ff+f4//qc2LRedUeFyP43Drz+SERtnShGiFmi/rODnfvg?=
 =?Windows-1252?Q?/oGi1Fndp+K6ircqgmgA0vrko2DMQvJ9te5AGkvwbddfaUl+G9QC8BdP?=
 =?Windows-1252?Q?iZb8NUHcJY9qEv9OlJKlaL0Yga03r2gHX+Rm9F17e2toA3VnloRWGcLI?=
 =?Windows-1252?Q?HxyWmniW3E4RPVpHQS8fDgtAnI4tJC2xaFbYfpflpERF8mTttxEAya/W?=
 =?Windows-1252?Q?csGM+ovSa/D027bMWZyk5eT/48g0SG4Cs4o5+l3bcME6EAjAfXwuz2ZM?=
 =?Windows-1252?Q?vgXl5yoqC4w9zwIqpelQZzJpDrrqVKs2N8XHBncZMHBLkf3uoYquyYDT?=
 =?Windows-1252?Q?tOvvBfy+21h3rb7Aki4miPfZvWoeQbjboMxvPGd3yB38kex6cboU+fxS?=
 =?Windows-1252?Q?Y+lZVUAFhD7FpEAbwjDspo92Yv0rnDkKd56NjAOyfYhdcWaSSdpxHH2A?=
 =?Windows-1252?Q?tidBC3VElhQbuattyEX+9Y39VcRDtkFlrsaAMOlobzW0Ui2y5k3Iv87R?=
 =?Windows-1252?Q?P7gkbFAHbmJK8zts7EUs5t+4/BIXAbsu+ShdBOcn0xV2Np05MkszbkQn?=
 =?Windows-1252?Q?mdEMiE4oqDlZ11Q35V1EKQ4lGDE10UkXNARLYesgyoOz25LaGMhmAU5u?=
 =?Windows-1252?Q?KnK3qNvPjkNHEFNQ7jMeO7nOn5/smhO1kTw49YmsgDN96F7S9man3lWm?=
 =?Windows-1252?Q?dX/YgPR4oH8rjfCAjjVsfeXqUVLe6m5fPH4zOAGZhuBI0D3MWf1/oUWx?=
 =?Windows-1252?Q?49Um7gsHT2riZqUbCSExLzwmO6LSlXhH7Cbn2LOC4Oq2VnAEqAVxBZhM?=
 =?Windows-1252?Q?ZxUHpi4bVs0g0OEJMkZNIe6IEEPfe81rO3MGBpOrLBkkeS5v+lpfbJJn?=
 =?Windows-1252?Q?i0umlhqtM4Xs51l8SRhlxovhDPd2wHnU+/9P9glxyOBTupNg0JEe3ToD?=
 =?Windows-1252?Q?bHPWOcBXjPeZr592LFaO6SegFWE02hjDYCLPVEj9hZV8NBYG+GzhJ7Qr?=
 =?Windows-1252?Q?6QvdjUQ7H/CPlPbb91Dl+UnfUe3jAAwonONcsKOSua6Yc1OaGsYp7k+b?=
 =?Windows-1252?Q?2YyKyrpGNyyB4PTCtw2tjAH0XzTIR6/Z3kvbaB8NgyF6qBd93xEHe3BC?=
 =?Windows-1252?Q?Ky22TDACMxQhYIsLpN5lv734nt3NGtKuYkRswiEQCbEoVF4Nf/h+uy7C?=
 =?Windows-1252?Q?blZ9vgaoEv+J1yBJ2Xq8LTotvRPdVLrEis0F+UJO854RecHSBIpHOnC+?=
 =?Windows-1252?Q?C2v3XBucSwAlDD24i1lxZz+a7Nk9G5aMC6l+jr7kRp9Wen9Pr+y6YyXd?=
 =?Windows-1252?B?dz09?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3205;6:JYq8AW0h2emVtqlDVBQhAcAWy7SPilhodANtajKa5CCEAT4XsC1A297ugytyhrQYbIeIjCZtcrUHPd43j1uNsPN+HsDNGxmEe6OCdNp3yM3+eQAI6wc3MG7YLsVU5lWABtd0YT6ohXvNLYKc27sxfVWLRdGZZuU6VVmWVSTXZyDf9UfJ4SopC7AiD5W+hnfo4jrckE+3cX5V0AcY3wmF7RkCr4S7BYzIpXPBq78IWGg71TFRCCkLK6e1Sl03GoHrGrYjZ7fK6uo4rrQHCjFeMQoLQzcGSVMf0hfMlOEEBCq1atDEc6xEGXM8tLOLFWjMIKDH5HmTDYGmX7MVaD6hVjR6NAoLFivFFpkpWLWvICp8FiLj/9D1iIxcelg/IIs4YKyXf9ljRum5bdBGs71gsekpqYO3zGeWb2Vkqgfyef57HnDEesyOZTrUiRhY0LRpFh46UIfGus2lHNp2tEzyDQ==;5:LE1jh/pBc61Yh17lzll5KeL9AuKhR47sIRbGkvSZmahG4OWKQy2p88aD/u2mNK+p1fgBoWw4dms5euiW9BYOROhuufcIXafHaBMV6sGCRnUR7pb1JTc8Op8DPXbnsWsQ+b0t3UEBmQ8r7leAiWh1OsEhfIpzj39NuKsEj/ZDSWE=;24:5GjQXWlaCWy86cMT9cXNrJV8RM4x7gZOOX7bMPMZeqLQTSLZ9xNDf3Oij2Szq86qJn1WV40UXo6W6FbRzxg5KOmS3xFq09zUY/UwH9JdhMU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3205;7:ECSFfwKyJn7MqgzZVRubo4v1cV3WhG4o0Mf7ySnZA7lCphxXmYtckKsFRxWbC/kcF7KkMAqBpHFleXWeoeoCMH+ceBoaMSGbTkl9aLqvhElpw14vI+xccmQs4vRhguiF67IRKhsLhHNrHODhF6oVcxYarEHGVar2dwKuRqPhnaNCD2G2WfIG1VisDiRzOiaEE/Jmd5zVn41DhcKT0dXbxCbH7KWklY1Y7i67GPZNUxZXLdIxJkpuT/P+4VXs1USos7SblaetvTJqWEQmbyJIJwDVyHW1fikaejqW+oiD2IcyjxUKlPSAPSA/DRowFA3veHAfUL3N9z2BuTnPOOzLM6UPVBraPH1sOZXyZCmvfJvIw02uH8b5U7itS2wYvd6ZMR2ftsc4kUg3LSO145ebDWNs3a2ABdsH+zg0WZ6f69sasrDxomFpGiPj1X/vRrew1nx2yH46S02sg0XH7M1/FQ==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2016 19:10:34.0609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3205
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55910
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

On 11/29/2016 12:37 PM, Wolfram Sang wrote:
> 
> Okay, I will pick up patch 1/3 from Jan (the revert) and read your
> comment above as an ack. Paul, is your tested-by still valid?
> 
Just to be explicitly clear, the patch revert allows I2C on OCTEON
to work again. I apologize if that was not clear.

Steve
