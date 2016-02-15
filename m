Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2016 12:20:03 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.17.13]:59160 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010789AbcBOLUBs0izj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Feb 2016 12:20:01 +0100
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue103) with ESMTPSA (Nemesis) id 0Lgf13-1a9uXy0XHJ-00nyJR; Mon, 15 Feb
 2016 12:19:35 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] MIPS: DTS: cavium-octeon: provide model attribute
Date:   Mon, 15 Feb 2016 12:19:30 +0100
Message-ID: <11778231.uWbmaTPDrr@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <56C1B3A0.4090301@cogentembedded.com>
References: <1455513977-934-1-git-send-email-xypron.glpk@gmx.de> <56C1B3A0.4090301@cogentembedded.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="utf-8"
X-Provags-ID: V03:K0:GlFwwoqL58eXfiOkJr221KX8IZxq4XpVVXoX+yJjti25OoFh/Cr
 QFdIQYbfiRUkHY20u4HYDXgjcUlk15/nQeTL99qez6XORTr749obLfUexXautkEZNEEXVIY
 EVS73FyCt297F2S7yVtHHPLt0QPb6mhwtluWxxqPFaajc8r5OMLkvNaNvXxrgXY4+wBluF3
 1/+q3+7layRtAhLIoDi/w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9tbaz9rut3Y=:Sjd0Qj0WG2VqIw+xC1/bUg
 gDqiVchwSsipGv4lE7R/sTLy4U7tvKh0+ept5+iBu6BNzY+TaEWbifrYDN5kQ1JedilfWvXke
 6e1owdF8HNTtj8WcaTQEzFJHgoh6DT5pjwT4gkL2VTdomQAkoGVaAczsjMKH6dZaAw3Pi6cq1
 3cidlRpBRG968GHupXxOzIWMRJioAzhoEG6HB2S6r/52t/4As9u5WMy5MPsVxHx0t093djCJb
 +n26JctClQh8L43tnInaudos4nO1nXdsv4Y6i/e/cBLDLSPDMX6gx3vWlwF+6DGV28QDykyES
 VOMSXnPl1Md0PeOFM1EkdIKhKEAudyhGEBYuAW+mfrHce+O89hnxGr9D4D9vJJX+XnP2uDGk9
 gDSZOQ/eG2172A7l2CiDfHcpgL1QIHkBwpkzRnCG1zFvWDn5BG7k8hIZXcRQ1x6PF5PZju2XM
 cOzUnI0VnXVVkRxNchllxIuwgYE6akCUR9hgDThxCwdAEkaPiEToIPc7PkLOmEjL2cCOqIzIG
 B75vaiUB9kKtzJyNGHtdNudI9qts457BZs03EEU+2L5xUgaLhikfyTZ2HBM785Jh3k1qUyuTW
 JaNIsJV2m4Cwv6JujkfGj6j2F5WZHu7Jcohd7n0B9aVx3g30sES1LRPFQQl0KDkbCw30KjClg
 0T5j6Tx0RrmwYGjHeMTzJnyzCNVfOQXOOgtMyZ8J4F9felcG6k3pj0dwkGpes6cbcIJVAvwS9
 mkG+dYcHNOo65sl5
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52058
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Monday 15 February 2016 14:16:48 Sergei Shtylyov wrote:
> 
> Property: model
> Value type: <string>
> Description:
>         The model property value is a <string> that specifies the
>         manufacturer’s model number of the device.
> 
>         The recommended format is: “manufacturer,model”, where manufacturer
>         is a string describing the name of the manufacturer (such as a stock
>         ticker symbol), and model specifies the model number.
> 
> 

This also means that you absolutely cannot have wildcards in there (same
rule as for the compatible strings) and that the property should be in the
.dts file, not .dtsi.

	Arnd
