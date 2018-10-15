Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2018 01:40:13 +0200 (CEST)
Received: from mga01.intel.com ([192.55.52.88]:9832 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991162AbeJOXkKA1Str convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Oct 2018 01:40:10 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2018 16:40:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,386,1534834800"; 
   d="scan'208";a="88599796"
Received: from irsmsx107.ger.corp.intel.com ([163.33.3.99])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Oct 2018 16:40:06 -0700
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.4]) by
 IRSMSX107.ger.corp.intel.com ([169.254.10.56]) with mapi id 14.03.0319.002;
 Tue, 16 Oct 2018 00:40:05 +0100
From:   "Langer, Thomas" <thomas.langer@intel.com>
To:     Paul Burton <paul.burton@mips.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: RE: [PATCH] MIPS: Cleanup DSP ASE detection
Thread-Topic: [PATCH] MIPS: Cleanup DSP ASE detection
Thread-Index: AQHUZLSNncF1I35ZS0mNMRNssfFMmqUg9iTw
Date:   Mon, 15 Oct 2018 23:40:04 +0000
Message-ID: <0DAF21CFE1B20740AE23D6AF6E54843F1F0AE192@IRSMSX101.ger.corp.intel.com>
References: <20181015182600.15423-1-paul.burton@mips.com>
In-Reply-To: <20181015182600.15423-1-paul.burton@mips.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZmQ2ZmI3NzAtNzhkMS00NWU1LWE5NWEtMWMwN2JmOTJlZDNhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVVwvMFIrZWQ0cHdGVlBEV1pIOVJqVUJkKzc3clUxTTMyRkQxY0RJTEN1Z09ybzllXC9mN1c3REw4UmJvSFhQbzBYIn0=
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <thomas.langer@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66858
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.langer@intel.com
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

Hi Paul,

> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index c28b9bf617d5..a8f8ca8ccf89 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -231,6 +231,8 @@ toolchain-xpa				:= $(call cc-option-
> yn,$(xpa-cflags-y) -mxpa)
>  cflags-$(toolchain-xpa)			+= -DTOOLCHAIN_SUPPORTS_XPA
>  toolchain-crc				:= $(call cc-option-yn,$(mips-cflags)
> -Wa$(comma)-mcrc)
>  cflags-$(toolchain-crc)			+= -DTOOLCHAIN_SUPPORTS_CRC
> +toolchain-dsp				:= $(call cc-option-yn,$(mips-cflags)
> -Wa$(comma)-mdsp)
> +cflags-$(toolchain-crc)			+= -DTOOLCHAIN_SUPPORTS_DSP

                      ^^^
                      dsp
