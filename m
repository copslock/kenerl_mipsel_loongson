Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Jan 2014 22:50:04 +0100 (CET)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:43760 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816015AbaAZVuCpuKdQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 26 Jan 2014 22:50:02 +0100
Received: by mail-pa0-f50.google.com with SMTP id kp14so5172813pab.37
        for <linux-mips@linux-mips.org>; Sun, 26 Jan 2014 13:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tpDpFFn829fN4D7QMHijGkze98X5BbmoMUDpWf3GYac=;
        b=VnCtdIyZ4vkjNbRrpbDE9Xu4B2MPeosx3zwZU66YRDrP+trpJxr1JbR67Kh0Qk7m7R
         vDCUoHhfyOxBYBQqtI1ByL1N88j9iJWJAntVgft9UducR5I4rMDeOQEvr7peY/aBOGB4
         We4JasW6RIO+5uFQwGH8quvkSLUy7tr68kcEZsmtnFHGtSJGedipcNdcHDyUvTYMyT7N
         8pxhqbX9gcULCOrZx9+kcJHhgzBiWoP+5h37xnU83qFFjAg2EQO1qoxHDyPoZ71KYmWB
         X35cbNE5Eu4F4p+Lwu44LeoJy6jy/WVmY8E3YxH4jsohthsfOLPQOmZTh0jXm1/HlWOm
         jSOQ==
X-Received: by 10.66.224.109 with SMTP id rb13mr26406055pac.78.1390772995634;
        Sun, 26 Jan 2014 13:49:55 -0800 (PST)
Received: from mailhub.coreip.homeip.net (c-67-188-112-76.hsd1.ca.comcast.net. [67.188.112.76])
        by mx.google.com with ESMTPSA id jp3sm25243995pbc.36.2014.01.26.13.49.54
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 26 Jan 2014 13:49:54 -0800 (PST)
Date:   Sun, 26 Jan 2014 13:49:53 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Raghu Gandham <raghu.gandham@imgtec.com>
Cc:     aaro.koskinen@iki.fi, linux-input@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: i8042-io - Exclude mips platforms when
 allocating/deallocating IO regions.
Message-ID: <20140126214952.GD18840@core.coreip.homeip.net>
References: <1390676514-30880-1-git-send-email-raghu.gandham@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1390676514-30880-1-git-send-email-raghu.gandham@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dmitry.torokhov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39091
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.torokhov@gmail.com
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

Hi Raghu,

On Sat, Jan 25, 2014 at 11:01:54AM -0800, Raghu Gandham wrote:
> The standard IO regions are already reserved by the platform code on most MIPS
> devices(malta, cobalt, sni). The Commit 197a1e96c8be5b6005145af3a4c0e45e2d651444
> ("Input: i8042-io - fix up region handling on MIPS") introduced a bug on these
> MIPS platforms causing i8042 driver to fail when trying to reserve IO ports.
> Prior to the above mentioned commit request_region is skipped on MIPS but
> release_region is called.
> 
> This patch reverts commit 197a1e96c8be5b6005145af3a4c0e45e2d651444 and also
> avoids calling release_region for MIPS.

The problem is that IO regions are reserved on _most_, but not _all_
devices. MIPS should figure out what they want to do with i8042
registers and be consistent on all devices.

I do not want to apply this patch because it will be breaking devices
using the other configuration.

Thanks.

-- 
Dmitry
