Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2017 18:58:34 +0100 (CET)
Received: from mail-by2nam03on0087.outbound.protection.outlook.com ([104.47.42.87]:34334
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993890AbdAQR6ZVvVl0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Jan 2017 18:58:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=l99VBXNDSFVmt96p6hBYoyTQYxEDJApMceYGZhZMkwk=;
 b=B9SygXB/4Ak1OITJhKjkAQeuhvKtUoOJ4UeenVwgcbK+1gyVbTcLSfFhI0wXPBg9v3fZ5rd6MnaC/grWg7GdvGIo+EDkVGgBMgIF+TxWlcvYczdEe5HYQxxknbjj6uCRqA8MHlCuOwl/JxDCv+nlMMrKoP6lqPjRPkyYEMzaEcc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM3PR07MB2137.namprd07.prod.outlook.com (10.164.4.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.845.12; Tue, 17 Jan 2017 17:58:16 +0000
Subject: Re: [PATCH] octeon: prom_putchar() must be void
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
References: <20170117173644.27984-1-alexander.sverdlin@nokia.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        "Steven J. Hill" <steven.hill@cavium.com>,
        <linux-mips@linux-mips.org>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <3cdd9280-1ef1-78a4-ea75-290b9c91cf93@caviumnetworks.com>
Date:   Tue, 17 Jan 2017 09:58:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170117173644.27984-1-alexander.sverdlin@nokia.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BLUPR07CA092.namprd07.prod.outlook.com (10.160.24.47) To
 DM3PR07MB2137.namprd07.prod.outlook.com (10.164.4.143)
X-MS-Office365-Filtering-Correlation-Id: 89d14c61-ee33-416a-bee6-08d43f026a37
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:DM3PR07MB2137;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2137;3:/+tWvGbLs6l6bIXHtaNGcaeatRU6LWNux79IuAiD+QcJ/5E5FKWwYWeICJTAS8jJwBFR5AW6HmLeHBU1Q3LmODcKoZcB62qcSZvcy+zoVBn2vBfVIGojmqAORY88wu8bBJex2R+EM/EEmkEe0L7ePMHbSEgLfnLCopq9YrMiZ8yS76/9yC4/sIsVfOoRBfCUyN472zrbu2meu0EAoTSEHzuZ3CrdPdT+xL+p1rGFTGVVE9nxRzRNhwUyWwXfm8x9lR0hWkNMbY7GodLQeDUdqQ==;25:ELUBK4Lc29eSU9zxKXm8Wfh4Xze7zq/Uyib63j8F6mnh9kbV0PIx6eJRCVsUFWuoiEvtFe3DCi4JnHmHuukP/4umUQfzguO7sA9kcbY6cRWwRbGuLostGNNlfss1CJABm+uXcHOizPNKLv8UJguFmFpHWhaRLdf8Ybr0Rwa9wO8TtrLEiaILw5dHtff5On3mmQwRzoDMkiybOwkPueTQxvARMhwMpXMftGsPyJAZKdNJMVd8afKJyDyIEM2PmoqrKExxionKgJSAdiuHeimpWLOmgxAPP/A33If9Z2FWkNoU0uyEbGYNIHbXXn4WlQVf05cqDAy9U0fm6Z9yZ/9SAC0qe+o3HwXvz+M7vhwG9BTYU6rKjvq3Q9IQNIgVKOVep5lvANNldhS/IpmvmffqNWfv7VpQwAcqMAQdUdb36V6BQ9mCBMrlqvmQ89bDsNgGGcBzITGFAC3u3QVGFXwAwg==
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2137;31:+lS4kz3cW3evgklWACitcdi6b4411qJ48+EfcWVOJNxyeNghG9W3DP4ZVdXpoXnBZax9nRiCT3pjq3ozEdGpwektnVuhVbEpTdRaNsHvQ2+THly72YcgVhQrNY7oz7go79RseIpVOyD824APRLolJtm9fn/mPnPF8lMIdcnOSco4zkgv2CyqzjJTv3S4Ia1EnOKUA8eSkSJuAnObW7oEhIjssWqp5USLvgOaQGeUijh8Q6HRZ4Fqpv/A0i0ejco8+QrLUexz/7c59CKRC2BtPw==;20:D5PTzuZx9XhbZRsiAbE1bx18pFVHN6h914fX8OZq4iZ9JiGbMcxkyj8xMdZmLwIJFzVib/z7rH5JpPr1k9Fm7+g3e+a3oweP2Zrj8UDbDfTr6gNzmLvywegy1M5eDpkAJUYnqTaIFSqy5fTQcs65xST1xa7kDlqiKZFnwgMlQtqYagp35XBbXKK4vNsXLc5jLfCf9xAMtAf/TPktKkCycga9I1W5ih097xZgUBL38Tu0QVQL+eNB7FncBAqPEWymw+pJgpoBAHjHnNJqNnJWwNJa5IpUWhxe2uB+ofoQDw1jRAMkZuAjrJS/JLxfEigp2ijneb4Zp3NIND1MiHTSdm+2uPboSRIu4AvyGJ13RrsjozSOwvtqxZlxi5ufRIiLPrvePMXPIdJW55BJy0le1ZuluFKZBLHAKRBrIVIHH5iHKw1dvGZCrCNaXwin7AQ+Fh6GM0MixhIuHnIFwrjun1UPKC7pOnkpO9oPrG/ftOkkcAnCF4m5aHOI/iW/1Bgw+txcTGOJBAJnGaJ2MsdmWAv4xs/KF3hQXU+xnA6gQ+tTbM5S+1B93tODI+svRaLqt57JYe6USuqiJBPM9Chc+EEp9Xn+enaCx+e840+sWWk=
X-Microsoft-Antispam-PRVS: <DM3PR07MB213732187114711AF3F3F820977C0@DM3PR07MB2137.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6041248)(20161123562025)(20161123564025)(20161123555025)(20161123558021)(20161123560025)(6072148);SRVR:DM3PR07MB2137;BCL:0;PCL:0;RULEID:;SRVR:DM3PR07MB2137;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2137;4:Dld5TEYj3KpVRAnQjVqjvfcbrrNonP7kwHLn4RP6XtSwaRmonmBNoYLvRM5ogtEZNs11qwYioNRa0AAQGXea8fsFXZjqV8nsQL9E1QwbHeNdmVDe2MsM1ZP7YMZ38ou739CCC1C4mTOYFUiNPsRrNxul6DzRqv5lkZV00VzAssjpShPbyDfy8WS5mOTStcZkfa2P4NvNSGAEExyyk4loG+Eg2NArfDabAMtq7h09sHERJF7EV/xVfwBg7ItDyT1Cg9HTQkYeGMAz7o5Yt6pfc3CB1o6HeZ2I4L3+MTxFuD+HMa5ogo50vm8q7LmclYE2eu3KfiZMBm33oo0t6xvCPXN/gJgETU3MjoENdmvBJmFaj/D8mDylmzoTp77gyUHdzPQ4g33xSenxslJ1ZMKvvu/OtU1mbVTG+APe7LkMuOA6swzZbq0sKwk6EuEvIEnvb2sKq4Z5lgmIUVhmhvGB/6KaxIBj9Cr2QizLuoEBr6hMYSmFlQlKX9jGR6qnLSFnlKZAtVl1f/dDLlkSusOsRBsXclrFkz8e4Sf3QtpR6GvPOmvUoBFTq+yORUk9tGj/yU2dhC2KSnR/Eeq9AYooZjWaV3EpiFcLA1eAYqh/dYQtxJwnu6p3gM6wwQqreiQDgYMenqcoVIkkzI2DeACTVw==
X-Forefront-PRVS: 01901B3451
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39450400003)(189002)(199003)(24454002)(377454003)(38730400001)(25786008)(97736004)(305945005)(229853002)(68736007)(66066001)(65956001)(65826007)(23746002)(50986999)(65806001)(33646002)(7736002)(76176999)(47776003)(54356999)(5660300001)(6916009)(230700001)(189998001)(110136003)(36756003)(64126003)(6486002)(6506006)(31696002)(54906002)(42882006)(6512007)(101416001)(53416004)(105586002)(2950100002)(6666003)(42186005)(31686004)(106356001)(50466002)(6116002)(3846002)(81156014)(81166006)(4001350100001)(4326007)(8676002)(2906002)(92566002)(83506001)(69596002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM3PR07MB2137;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;DM3PR07MB2137;23:QLlvTsLRLoOGngfAB2bAD+rO/RLCiIbyAW1j+?=
 =?Windows-1252?Q?cxo0FGf7q58hfxZY1QSPF1sR8SqleUY1nKy92GACb763/Esf2EcClYMs?=
 =?Windows-1252?Q?88/3JKKL6HZw95qk/f0MCO1xsnOSvB0WVUu5gPIw+WNqPmOJ9rYmlCi6?=
 =?Windows-1252?Q?HYdBYdYY2rrhnnUjjc9UDOdZL1MCErp8jT1tO9bI5T+HKOcOkeS6bCMw?=
 =?Windows-1252?Q?M34sskRTU287qEOafK2Vx8uenJGDNbCezrKx4bu1t45qPgO5vG1nIR3c?=
 =?Windows-1252?Q?90Xx3AAimYP4zaoWWZYbuz7gERzZHEgussfiP/bnBgBxT898FAjtCBz+?=
 =?Windows-1252?Q?RO3F+h5Z7g9IOOaelvpOV2IryTsjy0esFHUPcYleFyDSOSW+1z24kElT?=
 =?Windows-1252?Q?Ng8JdSDexDKgsAAX6IQXEbzyyE8a5cNFaZ44TorYjJE4h0vQ/6+KPar7?=
 =?Windows-1252?Q?o1AUb2EyZNZZI+dJTfSwfhJFpZ7te000bweJdd5jhuqzCPFZjOZYlFhW?=
 =?Windows-1252?Q?2AQHGTVHbjeXZqNjdJhKwq44Y+ySEmiOC7OjIKCJ2UEp8WvmAtUR1nsw?=
 =?Windows-1252?Q?zLcXDAFhl2eUfAnstURFVmD8iCyf5uLsZ0UFkUi/thVDjxJx4B5N86gI?=
 =?Windows-1252?Q?yCYdrA7mYo0QYULUpfJjIYhXBiYfNrFiAFnvixHHv3kpcEe5oGYzBZQP?=
 =?Windows-1252?Q?WPIMNVtidL8lFbHOmrSINQL+vNQ/fR1Ya6l71pi57qUushcWN0cHa+7n?=
 =?Windows-1252?Q?rpN+mlk6aRiYEG5sHtZXKa1ge0rwgW7lGq8NPmtZHWza8iGdP97/DZOw?=
 =?Windows-1252?Q?UsuITzs4+F+WfnI9KUWvAkP8yUIF5Oslgrw3gl1dznArLmWg9nLokjAc?=
 =?Windows-1252?Q?MiU8sZSK/a5G7nB4jNrljDPmHmL2xHAQ/9yFAtKpWQ0ecSBgl3Cedxdy?=
 =?Windows-1252?Q?xyZ+nx1ro3bB0XcG/VgXxgsuM52ju4WcleOJIbfLWtP8GD6WDCwLwENg?=
 =?Windows-1252?Q?qmjIEHte1vFxPV/N1T/TTpP33hsSiQAydNp5jaNuJEQESodX5LfWtZ72?=
 =?Windows-1252?Q?PZV3zlxvPsE+i+1jT8af6v2uy3CnZAC06BeiJWvRQIw5cUNTLaH2Aa5F?=
 =?Windows-1252?Q?SRpVEXV7JDJtK5ui2BknbTk/rwd4781sAqKSszYsNxOxS/JkGs9JhXKb?=
 =?Windows-1252?Q?vKo3GaBTCaWPHUlUCZGZT27LtOMtj8BV9qUk0qKg9kGvaF08Fohdhs4W?=
 =?Windows-1252?Q?GA9ISokR11TKQdzBtdJfnYZu5IPQj99PKnVWrpYknz3aCvY3Z0rP7z1U?=
 =?Windows-1252?Q?l8XMfq2dzbs3UG/x0N/BlXkyC1rs/NKpW3gECgs0fMxtrHVce3F5jwm+?=
 =?Windows-1252?Q?PM9iY2OWfwMbuInCmuebGjnvcVgIL+HpoLfZlRSFvT8viK4hpsr3l9ty?=
 =?Windows-1252?Q?DlcgnvDNPbNl93sJdd6SxQYcX4+tvE2M9CZGtohLL5FiQU0GaJTCvG8c?=
 =?Windows-1252?Q?tD87V4=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2137;6:/amanoKkbv41Tv+GCZAdZ5s6NJdNk3b+q9NgsPviZ+5J/q2GH+sbnsxJt3HCgGR7RF7AsMDQNssBW6RvbB+weTJbQDdoE9okmhhdTYexrESPiD7KnYn7c8CzUkc4c7htwYtQMlo77eSvzhJzA8IAWXqbR29eZ8yqlwd7GLlbWQuNnFnwtdWoWVRA/zlfqR3kMIrxv73OHCxY5h8Wz1VBwgUNn+lbD/8pNUxG9D3I/pgQ3t2QkEjnmO3AcDGYcF92XYIJIp2PmvVGqxFRbx7C2F3O1jow4GCM6BnjO/WebM3HpPU6akrsrIU0ItOgsnn6yTJMp6wKcaQ+/xVkM/t5jqIOifkhaKYeiebs4DexWycVZDO/mfnoXAuEK+EvVvCLQZB/lZ6hw0m23vuxeaki9loXVE2bi7CDXWR+CMAQDfg=;5:zLlEro52H8mH83NHwywptQLYc5D1qAgvFTIaiCPgUSWaklVS4A8qCA7C1d63N4yKYNN/FZNe4UuwPH3h72gizeAuQ46FVZOqYVytG012idJOQCseCvKNIYBvHRGbKFLqSyxziwRRD9Z2AjWytHY5j8xCsd3iRETgcuJ+2z1PRfo=;24:GeKM8hprxo4YI95tqTit8tWyhVKPLZJW0+29KVD8MnYt7rhRFsnqVrgeK/LXVqA/WWjp/O+tISvW8tGcX5SRsdU4D6JGiBgr1H86V8VbtjY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2137;7:iIScwL5rWj7BBWQIk4dHhYASn78XyQNXVi0lJ1QtKeBc1CZyh4D2cmvxyEN9vuEDifla/xuRuXj/hTF3MVrNdPsmroXkZxOVe0GE3uswU/zGU1gIKyLnSV1sp12veq4qRzbZI5phuklGzd3B3rQ+n8w5x+hpCfoLjxFMch1ziH4nLItHuNCZWQk8cjD0u31PW5T1qauizPL5XBX0QQlDLSlIFhO7m6qic4KZL4+B06y84dF/A6PBMV6TmsLOdMWJHJuI3qOd5N7n+bGgP7u/nB9vFGfvK+YfEokDwOnhBgsNFlCPNk+l1a5SN3JDhIsREkj9b/JKEtiV/TY8KcTVXvimmqzRw+VI+MeNUUyAPJx+nUlrhGkptZXTQpJxB2usk2gR/cPf1Sj3m4+R+GlK1JYIMR8X83NNXQ4MV3F+penWqr+mlHzAXTPfVQvc6ucFXY/wAIqzXonsHHsyStkZRA==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2017 17:58:16.2428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR07MB2137
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

On 01/17/2017 09:36 AM, Alexander Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@nsn.com>
>
> Correct the function return type.
>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

This will make it conflict with the declaration in
drivers/watchdog/octeon-wdt-main.c

*Iff* you also fix the watchdog site, you can add Acked-by: David Daney 
<david.daney@cavium.com>


> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: David Daney <david.daney@cavium.com>
> Cc: Aaro Koskinen <aaro.koskinen@nokia.com>
> Cc: "Steven J. Hill" <steven.hill@cavium.com>
> Cc: linux-mips@linux-mips.org
> ---
>  arch/mips/cavium-octeon/setup.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
> index 9a2db1c013d9..bb613d3e5246 100644
> --- a/arch/mips/cavium-octeon/setup.c
> +++ b/arch/mips/cavium-octeon/setup.c
> @@ -1095,7 +1095,7 @@ void __init plat_mem_setup(void)
>   * Emit one character to the boot UART.	 Exported for use by the
>   * watchdog timer.
>   */
> -int prom_putchar(char c)
> +void prom_putchar(char c)
>  {
>  	uint64_t lsrval;
>
> @@ -1106,7 +1106,6 @@ int prom_putchar(char c)
>
>  	/* Write the byte */
>  	cvmx_write_csr(CVMX_MIO_UARTX_THR(octeon_uart), c & 0xffull);
> -	return 1;
>  }
>  EXPORT_SYMBOL(prom_putchar);
>
>
