Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Apr 2014 19:16:45 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:56454 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817513AbaDRRQkh0PcG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Apr 2014 19:16:40 +0200
Message-ID: <53515DF2.8060106@phrozen.org>
Date:   Fri, 18 Apr 2014 19:16:34 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To:     Leif Lindholm <leif.lindholm@linaro.org>,
        linux-kernel@vger.kernel.org
CC:     patches@linaro.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/3] mips: dts: add device_type="memory" where missing
References: <1397756521-29387-1-git-send-email-leif.lindholm@linaro.org> <1397756521-29387-3-git-send-email-leif.lindholm@linaro.org>
In-Reply-To: <1397756521-29387-3-git-send-email-leif.lindholm@linaro.org>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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



On 17/04/2014 19:42, Leif Lindholm wrote:
> A few platforms lack a 'device_type = "memory"' for their memory 
> nodes, relying on an old ppc quirk in order to discover its
> memory. Add this, to permit that quirk to be made ppc only.
> 
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org> Cc:
> linux-mips@linux-mips.org Cc: devicetree@vger.kernel.org Cc: John
> Crispin <blogic@openwrt.org> Cc: Mark Rutland
> <mark.rutland@arm.com>

Acked-by: John Crispin <blogic@openwrt.org?


Thanks for the cleanup ....


> --- arch/mips/lantiq/dts/easy50712.dts    |    1 + 
> arch/mips/ralink/dts/mt7620a_eval.dts |    1 + 
> arch/mips/ralink/dts/rt2880_eval.dts  |    1 + 
> arch/mips/ralink/dts/rt3052_eval.dts  |    1 + 
> arch/mips/ralink/dts/rt3883_eval.dts  |    1 + 5 files changed, 5
> insertions(+)
> 
> diff --git a/arch/mips/lantiq/dts/easy50712.dts
> b/arch/mips/lantiq/dts/easy50712.dts index fac1f5b..143b8a3 100644 
> --- a/arch/mips/lantiq/dts/easy50712.dts +++
> b/arch/mips/lantiq/dts/easy50712.dts @@ -8,6 +8,7 @@ };
> 
> memory@0 { +		device_type = "memory"; reg = <0x0 0x2000000>; };
> 
> diff --git a/arch/mips/ralink/dts/mt7620a_eval.dts
> b/arch/mips/ralink/dts/mt7620a_eval.dts index 35eb874..709f581
> 100644 --- a/arch/mips/ralink/dts/mt7620a_eval.dts +++
> b/arch/mips/ralink/dts/mt7620a_eval.dts @@ -7,6 +7,7 @@ model =
> "Ralink MT7620A evaluation board";
> 
> memory@0 { +		device_type = "memory"; reg = <0x0 0x2000000>; };
> 
> diff --git a/arch/mips/ralink/dts/rt2880_eval.dts
> b/arch/mips/ralink/dts/rt2880_eval.dts index 322d700..0a685db
> 100644 --- a/arch/mips/ralink/dts/rt2880_eval.dts +++
> b/arch/mips/ralink/dts/rt2880_eval.dts @@ -7,6 +7,7 @@ model =
> "Ralink RT2880 evaluation board";
> 
> memory@0 { +		device_type = "memory"; reg = <0x8000000 0x2000000>; 
> };
> 
> diff --git a/arch/mips/ralink/dts/rt3052_eval.dts
> b/arch/mips/ralink/dts/rt3052_eval.dts index 0ac73ea..ec9e9a0
> 100644 --- a/arch/mips/ralink/dts/rt3052_eval.dts +++
> b/arch/mips/ralink/dts/rt3052_eval.dts @@ -7,6 +7,7 @@ model =
> "Ralink RT3052 evaluation board";
> 
> memory@0 { +		device_type = "memory"; reg = <0x0 0x2000000>; };
> 
> diff --git a/arch/mips/ralink/dts/rt3883_eval.dts
> b/arch/mips/ralink/dts/rt3883_eval.dts index 2fa6b33..e8df21a
> 100644 --- a/arch/mips/ralink/dts/rt3883_eval.dts +++
> b/arch/mips/ralink/dts/rt3883_eval.dts @@ -7,6 +7,7 @@ model =
> "Ralink RT3883 evaluation board";
> 
> memory@0 { +		device_type = "memory"; reg = <0x0 0x2000000>; };
> 
> 
