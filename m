Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Aug 2018 18:47:26 +0200 (CEST)
Received: from mail-by2nam01on0126.outbound.protection.outlook.com ([104.47.34.126]:55987
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994590AbeHaQrXtjJ4Q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 31 Aug 2018 18:47:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdelr/qncBiy+m7m5lLhtrlFR72wTNPFL5IpjiqqkHE=;
 b=bNtNwZ5GEWJRXJAHqWKx65HAVPiITO8B58dlALCgv2ZUgaEI2yyGlItw1DxtSiXOj/eGm+Ku0OuOKdbh+iAL1nLgBrX6TG7jatMuY3bvZsNnLtM3/IVJTCzEE5aiiWcPhb5sMzThj9EC96vpX8AVxaCbQ7Nq+JGWEp/tXI1dSw0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 SN6PR08MB4943.namprd08.prod.outlook.com (2603:10b6:805:69::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.16; Fri, 31 Aug 2018 16:47:12 +0000
Date:   Fri, 31 Aug 2018 09:47:08 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Rene.Nielsen@microchip.com
Cc:     alexandre.belloni@bootlin.com, hauke@hauke-m.de,
        linux-mips@linux-mips.org, jhogan@kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: VDSO: Match data page cache colouring when D$
 aliases
Message-ID: <20180831164708.xuhybphyai3qwcyf@pburton-laptop>
References: <20180828160254.GC16561@piout.net>
 <20180830180121.25363-1-paul.burton@mips.com>
 <CY4PR11MB0069B3A54A04467564CDA481990F0@CY4PR11MB0069.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR11MB0069B3A54A04467564CDA481990F0@CY4PR11MB0069.namprd11.prod.outlook.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR18CA0004.namprd18.prod.outlook.com
 (2603:10b6:404:121::14) To SN6PR08MB4943.namprd08.prod.outlook.com
 (2603:10b6:805:69::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b48d6477-99c9-4194-f4a8-08d60f616695
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4943;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4943;3:Z1oSM7xmMp+V6KxKHw+SLn70aQ/z/3C+Hg/xbxFcCK3s96AYMrzy6px1ZlJ+LDXVaYjOhWVuccBLj88Jkc7vipLyUL7Bh4fNFCDjmw6A8vNFEbR20GiawCMEQv+2zN+lj2M99/pbwN3wcsqz5UCxQUfCye5gGd9BDTnXT6HVfDbjAJ5bP7S2ebuHON26+5ad+3agrO6EENJUoHjmI2jFQWprJ66Fy7cDkzoSl8rcVy9yBxKoQyP5CEbkXkMonY8g;25:QpgqLKMYir+U0zPtjBO8H2vGGLuupckFMIaPZzpvO8XzNeeQlJBRzpYsLPZ6ObGjRXiLZWm/OYp2zWYTUlWYBAVyAB9gqdZbzyYmF1j5WSr7zsFZr31MnNk5BIeSc89z3gfOOT207nVy3VqLUO0UZyus+tgiMjh6Ze3UFUVc0OteGFzv++M5nZ+muaX1WAyi7c6krmWQ8dEHdBc6IdErhbZ1a3CgAxi6aCrZc25t973hJA6dtXoDMew1XOQO0v2+HF47kFLyL/C8lzAYeMI/OZnfyID6+EyS1A7Kw7u7E99Ol7tz+byktyykDtYhwYcqjTgldYpRhjE1FwlbGCrQXg==;31:50i00Ndz2Sc+GuTNFMNEMeSvoz+GquT5brkj9zZr9wsTKIKVb7hluvz645xh9wuTGZvpHrFp/5en9XIBABUgED4A4GHc+Swt1WdbybGNpbc8I4SGUXWZ4viIZg/t5Wy6GjJlptgATHOxbCH1bJSMPr7Y0E3Ak2VjhdVpgmDdMoWwqkAS54U0W0kwp/nx3is0Zx66XM8x6XJ45tH4NMCz0uP19cEspQ9zSQalJPqHk1k=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4943:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4943;20:Jn/oqJnjQmHqWX9hdO9g+9W2BBXBxROJnzhmWlwwEdJLlOw1ggiG1SncYceoSb67eaxw/cjqXswBGamYn7ilfC8fobvMcJVEoEtBR+8XPFsgyDSjoTXEJKIUstRZqqJqvLJNtKOWhEhQr9PqxdERV5hVxOPa+92oL9mL0XSWeSrrDzfcdXDDp4indkeJ8FsWhpat5BD3fYCJNU+GkW7XGp7tFYb/fAeuiF3taaYnckhdelESmEXnUhEAKa1Af3dK;4:FQm+0Gojw3rPdNjeYD8Kfyn1q3pxhbkKg7F6JPObyw94mTaPabWvUh5/W344MCH9c/ijjwkVrHlBxVTcpiLUlEVoLZrXiUKQpLXHtNVVjeueW1VetqP9/pPffUdxthEycpd9cWWzi9FPLoZ3w6psHjdpdeHNH1P1d+D8TSmz/NXhvqGWeP/26xv4SxQZMs0Rwx9TzTlkTmY733SjIYRJjPji4FciNjs4jShljDEUQt5qEtgkFDg9ewEl5JmjYuD52vxhycd95iG8czvmLKZUrA==
X-Microsoft-Antispam-PRVS: <SN6PR08MB4943977F9AE680090E36019AC10F0@SN6PR08MB4943.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:SN6PR08MB4943;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4943;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(136003)(39840400004)(366004)(346002)(396003)(376002)(199004)(189003)(16526019)(186003)(229853002)(6486002)(42882007)(52116002)(68736007)(478600001)(66066001)(97736004)(33716001)(26005)(47776003)(446003)(7736002)(76176011)(305945005)(25786009)(11346002)(8676002)(53936002)(4326008)(33896004)(6246003)(956004)(6116002)(386003)(3846002)(2906002)(476003)(6496006)(6916009)(76506005)(2351001)(23726003)(2361001)(50466002)(58126008)(81156014)(1076002)(105586002)(16586007)(486006)(316002)(81166006)(44832011)(106356001)(9686003)(8936002)(5660300001)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4943;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4943;23:WIT6qVbOcaYSyNmBQayAZ3XphVRukQ9JPBDlnLoRC?=
 =?us-ascii?Q?Fxh9+80ztqBNkBY2AoOzvNARQQ4L3QNrGJ62qBTc98IwOa3QwNFIdWjpWQEC?=
 =?us-ascii?Q?utbE5Cy9LXJq6Ex86py828U6Ls/SR5B1phbQ60EIWoZM47uLIw7BtRF5EZc1?=
 =?us-ascii?Q?5n9FRUnu6YWsebV37r6hsK/a0Si7ZhUEPd+2kxi5t2//GTgUbqPbeyh8A0/o?=
 =?us-ascii?Q?rHJv9188FUJ7SU0kluH/Bdm/oEU1d5qLrHGXDuar/5GdlbJNsoZHZDoO0bAn?=
 =?us-ascii?Q?oLw1W5KIAzGz7d1pFl4G6/IIigZ0+Vv0eoWmfU8VztyXx7glWCfQVlRzQsV4?=
 =?us-ascii?Q?Ej84UJdrSqe5zLKAmr9zM4kWr9dQu/QnrBKEw8QenEY7+3ySHDRfqwiuLtjn?=
 =?us-ascii?Q?S9i1+isaIYj4ZdkW0jzfwmKEfJZDDumNIEAjgSt4p7n52nhqZQ5K343S1Bvw?=
 =?us-ascii?Q?X2MGjvYdIo0bQJXn807wOQQpRZ2+DqZfBgNFF3rnOKSBYxiW+d5ih3sjdEj3?=
 =?us-ascii?Q?flmd8ZBEAtixgXY4q0QTjQk25/BMSzWcGemql4g/IRyuLVLC4Zaq/oVXWVlM?=
 =?us-ascii?Q?QeybXDKt4cvrpMadvk+sl6oy39WYWjD3bYBkHB4LWuIW6YTPTGHaG81gDwlD?=
 =?us-ascii?Q?uIK6W2G+b7Dz/0E0lFqd4bTqPffJkywwM+TSiwKFj7ON+MHir1yEZBAYXRzx?=
 =?us-ascii?Q?c3Tg8TYCd2Zm2UmgDLXSCWoqdWQDaadDAX0YQIMTBTPZxj8Pvv9RmOW+pAKe?=
 =?us-ascii?Q?ay5LP5NaDNlj9nZ7Ndcl6WoeuKZsP0HQzzo763GyqGIcfuzj3aso7q6DKipE?=
 =?us-ascii?Q?N7l9Suaz6VbVWRUQxrD1YQyHSzuDe9jAxVEZpWoGCuV/kLE24A3gtJkgTCLf?=
 =?us-ascii?Q?lehk/PzC+4MHQi9xr3vBVe6SSEqYZCN+UD1mkBQ9gA67yi49oaOiLlh85HfL?=
 =?us-ascii?Q?48sFe3Q0DTl5wqJ0KYHoirh6lnYd0l6/mrwX2gYRoj1kNumFYq4VsUZGCs7z?=
 =?us-ascii?Q?0Mifgg315nQrSM2a9dhWorzYI/lYxI4DRE9rCQKfEpkWUQQVbKrQZfKMvUAy?=
 =?us-ascii?Q?rbIFYOeaaWwZvEEEP85NX4niVWHMb6p8r0L0kEd2lKcYA7c7/SPA+0/a2F6+?=
 =?us-ascii?Q?ce2Cw/eLSo4iidrXyOkWnnJjRTQk+Cp6tKoSJIfS47qvcOyf6ntmhhJFku1q?=
 =?us-ascii?Q?nCJYcJwfUvMb4ZAxOHHyeSoDyWngOhnJIvYTQIYCNiUWH/nmMkgApw7pifqL?=
 =?us-ascii?Q?56zYun7P8VlNHQEjb+qQYpr9mdMT0OsAN3WSRIML6kTDPsgjPOSz3REw7HsR?=
 =?us-ascii?Q?s99OonvQ4g28N6e/mTekaY+16Flx0/h3BoV1gxItgr/?=
X-Microsoft-Antispam-Message-Info: fzMwesXIdI2WOWXTnARSrtNyUzn5x+D79Y26ZneNUzGpKT7ZXHRfC8CeGz/gkQ+r7kWurMqAVHzKdAcrg05xl+0SJIwtJN9Qw73gDAGYENrjhCMktOvnIIQn5coE+fWI/Yiat5gdY15qIcuvl+gG3AxRe83FsQz/jcpzUgkaCjQ3jl/cVYGv5R6IJ5FQF09eX56aqkiuu0w5AOaGQ+YHo1tYhzCxfaWXSg0G4QyYsJfyWt8J+2NTv5iBCmM7xI4lC6eBkX6JXCDqcImOUbLpZqeyU2Jf8wFs2X5nvfebzuGVJphb4YVlIZOwD3Psp0pB623vnrrXCDn3L0c5HjUR5fNSA7tYoMsjMFy+VT9gfVg=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4943;6:YVI8zoebTqTuWCXdX5/W+TJRxgk+QTEia2vZRXqZ2Zd8mdeZtQVvTQ+MjQyAPKmvrH2DXtwSoBsjU2Ev6gQzizRJY3zEmLYugMc5/54IIDc6m507qKpWHLNIPujg7s8N7JZiYVJYtMmCPJOPnbGlNpZaq/kCCFLGbYdx9eVTynSb9yApPjmhanMVW2iKxFc+24QGS72u14RXjV8yp2U6tOh+ufk7xF7HQOeMS3IxWRwR/g6BLzFnbGJ8CAb/34qYAXZIFYqwn6aNux+1nE3VEUo/zJYwjlmMw2kQG4Z93uwHSjFdQcEBp2mzCjEz1AWV5paxD0IpF628FTK0hPEOKj0DBfRlLeCnsUgYs5OPjBKhTbmoF6Pqdk9IvWV6Omx1g/nEgra/z6SjNXFTquseZJsrHJSyiqt3+vsG9Xx6PGe2yOo2IUJwd0LiedzxwrkKUjeMNTz4MfzrRSs2kUMCXA==;5:lnntMDqAc6gVhTRlReARcezXfZXdUfo9CXaahvmtIEx+EHrtNTgaWHr0wrzvjEzavjjOBEsonRVjlBc5btUKbnG/mIfF0EHmZp2q4MewGeVic22EBU+VCkdW2DtGeStpNU/tpyIx41qnMbPrOD4lLkIfnu5b4yqSV5wBqdsjosQ=;7:ov3wXoVAbYIhxF+yO58tvSbBvUceSDchOLpEenqIrkt9aWR0+yNfy63qQC88zE5TcBEcSalV2r1yjSCk7TfP4CxKb6Zk5Q9c6w6af6kAlmKZ313zlFugVVawD0lIOd3szlnJh7KkmFLtdnmMhhM8w/8UTNukKpuYLWQXB11iY+HUuSlr4gDq2yoBEY/ajLMJUBhxjscdcneAzOXTyRYsV0YQABZ0l2tDqOLiGby86FnqFr5F170R6REBR6aJSOrL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 16:47:12.4195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b48d6477-99c9-4194-f4a8-08d60f616695
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4943
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65823
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

Hi Rene,

On Fri, Aug 31, 2018 at 08:58:27AM +0000, Rene.Nielsen@microchip.com wrote:
> With the error-producing version of vdso-chk-X.patch applied, apply
> Paul's patch and run the 'provoke' program again.
> 
> This also works.

Thanks - can I add your Tested-by?

> Paul's patch allocates twice the amount of needed VM, but I guess
> that's fine, as it's also less intrusive (no changes to mmap.c).

Note that get_unmapped_area() only finds an unmapped area - it doesn't
allocate it in the sense that further calls to get_unmapped_area() can
return the exact same memory. The actual use of the virtual address
ranges takes place when we call _install_special_mapping, and we still
use the same sizes there that we were before.

So my patch just causes us to look for a larger unmapped area (which
will typically be easy to find since we haven't even executed the
program yet), it doesn't actually use any more memory. We just find a
large area & then use only the part of it that we need to.

Since James' patch constrained get_unmapped_area() to look for a
suitably aligned piece of memory the result would have been much the
same - see the code in unmapped_area() where it also adds align_mask to
the length of the area we're looking for. It's just that with my patch
the alignment is being done by arch_setup_additional_pages() rather than
get_unmapped_area()/vm_unmapped_area(). That's not unprecedented either
- arch/nds32 already does something similar.

Thanks,
    Paul
