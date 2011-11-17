Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 20:07:11 +0100 (CET)
Received: from wolverine02.qualcomm.com ([199.106.114.251]:27854 "EHLO
        wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904058Ab1KQTHF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Nov 2011 20:07:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qca.qualcomm.com; i=kvalo@qca.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1321556824; x=1353092824;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  z=Message-ID:=20<4EC55B4A.7050001@qca.qualcomm.com>|Date:
   =20Thu,=2017=20Nov=202011=2021:06:50=20+0200|From:=20Kall
   e=20Valo=20<kvalo@qca.qualcomm.com>|MIME-Version:=201.0
   |To:=20Sangwook=20Lee=20<sangwook.lee@linaro.org>|CC:=20<
   mcgrof@frijolero.org>,=20<linux-kernel@vger.kernel.org>,
   =0D=0A=09<linux-mips@linux-mips.org>,=20<linux-wireless@v
   ger.kernel.org>,=0D=0A=09<ath9k-devel@lists.ath9k.org>,
   =20<ralf@linux-mips.org>,=20<juhosg@openwrt.org>,=0D=0A
   =09<rodrigue@qca.qualcomm.com>,=20<linville@tuxdriver.com
   >,=0D=0A=09<rmanohar@qca.qualcomm.com>,=20<patches@linaro
   .org>|Subject:=20Re:=20[PATCH]=20ath9k:=20rename=20ath9k_
   platform.h=20to=20ath_platform.h|References:=20<132135622
   4-5053-1-git-send-email-sangwook.lee@linaro.org>=09<4EC29
   534.7010502@adurom.com>=20<CADPsn1YDOu9Xyu1yDfs5Z0LjGzBL-
   Rx6Fk35AT8n-8oOPhPzHA@mail.gmail.com>|In-Reply-To:=20<CAD
   Psn1YDOu9Xyu1yDfs5Z0LjGzBL-Rx6Fk35AT8n-8oOPhPzHA@mail.gma
   il.com>|Content-Transfer-Encoding:=207bit;
  bh=cJytWx/MuN/PNZOnAcWJEQtJ19NGcfBih0OLVtjkK+o=;
  b=ekFeKSNlEZJR+xyZID4iyXGwZGhHl/3gMZytW6YFnZRjeof5yvlxeibI
   h4cYlxBbD2L5YglJMGdYL9d25Ai17TMwkZch6t/aDp1DZ81s2ki9SbXnf
   bsb7ixq5DWzjn7yIoy5+90wZmykyW9OUMlFxjnjZ+4maT1i85HN4f/1Kx
   8=;
X-IronPort-AV: E=McAfee;i="5400,1158,6533"; a="136291800"
Received: from ironmsg04-r.qualcomm.com ([172.30.46.18])
  by wolverine02.qualcomm.com with ESMTP; 17 Nov 2011 11:07:01 -0800
X-IronPort-AV: E=Sophos;i="4.69,527,1315206000"; 
   d="scan'208";a="197506715"
Received: from nasanexhc12.na.qualcomm.com ([172.30.39.187])
  by Ironmsg04-R.qualcomm.com with ESMTP/TLS/AES128-SHA; 17 Nov 2011 11:07:01 -0800
Received: from NASJOEXHC01.na.qualcomm.com (10.234.56.15) by
 nasanexhc12.na.qualcomm.com (172.30.39.187) with Microsoft SMTP Server (TLS)
 id 14.1.339.1; Thu, 17 Nov 2011 11:07:01 -0800
Received: from [10.64.3.78] (10.64.3.78) by qcamail1.atheros.com
 (10.234.56.15) with Microsoft SMTP Server (TLS) id 14.1.339.1; Thu, 17 Nov
 2011 11:06:59 -0800
Message-ID: <4EC55B4A.7050001@qca.qualcomm.com>
Date:   Thu, 17 Nov 2011 21:06:50 +0200
From:   Kalle Valo <kvalo@qca.qualcomm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110922 Thunderbird/3.1.15
MIME-Version: 1.0
To:     Sangwook Lee <sangwook.lee@linaro.org>
CC:     <mcgrof@frijolero.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <linux-wireless@vger.kernel.org>,
        <ath9k-devel@lists.ath9k.org>, <ralf@linux-mips.org>,
        <juhosg@openwrt.org>, <rodrigue@qca.qualcomm.com>,
        <linville@tuxdriver.com>, <rmanohar@qca.qualcomm.com>,
        <patches@linaro.org>
Subject: Re: [PATCH] ath9k: rename ath9k_platform.h to ath_platform.h
References: <1321356224-5053-1-git-send-email-sangwook.lee@linaro.org>  <4EC29534.7010502@adurom.com> <CADPsn1YDOu9Xyu1yDfs5Z0LjGzBL-Rx6Fk35AT8n-8oOPhPzHA@mail.gmail.com>
In-Reply-To: <CADPsn1YDOu9Xyu1yDfs5Z0LjGzBL-Rx6Fk35AT8n-8oOPhPzHA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.64.3.78]
X-archive-position: 31744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kvalo@qca.qualcomm.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14703

Hi Sangwook,

On 11/16/2011 01:34 PM, Sangwook Lee wrote:

> 
> On 15 November 2011 16:37, Kalle Valo <kvalo@adurom.com
> <mailto:kvalo@adurom.com>> wrote:
> 
>     Hi Sangwook,
> 
>     On 11/15/2011 01:23 PM, Sangwook Lee wrote:
>     > The patch series proposes to rename ath9k_platform.h to
>     "ath_platform.h
>     > This header file handles platform data used only for ath9k,
>     > but it can used by ath6k as well. We can take "wl12xx.h" as
>     > as a example. Please let us change this file name so that
>     > other Atheors WLANs use this file for their own platform data
> 
>     ath9k and ath6kl are very different devices, I'm not sure if sharing a
>     platfrom struct between the two is really a good idea. Most likely there
>     is very little the two drivers can share. What are your plans here?
>      
> 
> 
> As you know, if ath6kl is not SDIO powered (in most of cases, including
> mine)
> we need to use platform struct in order to control reset/power line,
> because ath6k is designed for mobile and embedded devices.

We have been actually planning to do the same, but it's still on our
todo list. If you can do this it would be awesome.

Also we need to provide some clock configuration from the board file and
I'm sure there will be more in the future. But let's start with the
power control.

> so I found out that there is already header file for ath9k's platform
> struct. How about using the one header file instead of
> "include/linux/ath9k_platform.h"
> , and "include/linux/ath6k_platform.h" ?
>  
> 
>     I myself was thinking that we would have include/linux/ath6kl.h
>     dedicated just for ath6kl. That would makes things simpler.
> 
> But since I don't know much about ath9k, if you want to make the
> separate header file for ath6kl's own struct, It would be fine as well.

Yeah, I really would like to use separate file for ath6kl.

Kalle
