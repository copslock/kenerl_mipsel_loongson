Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Nov 2014 20:01:39 +0100 (CET)
Received: from mail-la0-f41.google.com ([209.85.215.41]:42741 "EHLO
        mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013257AbaKJTBhntDN0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Nov 2014 20:01:37 +0100
Received: by mail-la0-f41.google.com with SMTP id s18so8403592lam.28
        for <linux-mips@linux-mips.org>; Mon, 10 Nov 2014 11:01:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=64nQl6kkfGJ9dduBlRm/WCDMm8q6kusjKQKsaVoGYro=;
        b=INpgx6fUfhxAHElkItiW/Wx/XP5VoSqqCCFRLwJaDBBWFSc8s7kd7x1+HuJWbqheVL
         5dVZqTMUzDLqZ6B28YqgnCKNHuD/nGxHUnztn08lXdQ7EwxBI3ePZcM7RaWLMvuXxgUg
         AzfPOWb5Xmfq0thVCrTbPnZvRLguh6PTUlJMJ4nbL3d57bpfCdv7EYipf8P97e76Vn9h
         L0AicQyAE8GrTnCQ9u1bauLZbFampeMwdugIegiJ4v/d0ompH2ZwODlnDVlXQn+zpL14
         6289A23KwFDfSI+CetP7FugTc8feIpeaq64V2XohLWLzazig9ck6p15i29TpMIsJbttB
         nFuw==
X-Gm-Message-State: ALoCoQlKh64lPX7CIZF7epHjS/luelabJCgz0bzDZqEamhSjmbprjij7NCI1PWZmyjzS3FCoHigZ
X-Received: by 10.112.136.37 with SMTP id px5mr31048141lbb.36.1415646092251;
        Mon, 10 Nov 2014 11:01:32 -0800 (PST)
Received: from wasted.cogentembedded.com (ppp19-29.pppoe.mtu-net.ru. [81.195.19.29])
        by mx.google.com with ESMTPSA id f8sm5466849lbv.39.2014.11.10.11.01.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Nov 2014 11:01:31 -0800 (PST)
Message-ID: <54610B89.4080004@cogentembedded.com>
Date:   Mon, 10 Nov 2014 22:01:29 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Rob Herring <robh@kernel.org>, Kevin Cernekee <cernekee@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Grant Likely <grant.likely@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] of: Fix crash if an earlycon driver is not found
References: <1415523348-4631-1-git-send-email-cernekee@gmail.com> <CAL_Jsq+iVfFGYEF575spQ5MaYPzo1QSfLUZP1M=TpH0+HdGS6A@mail.gmail.com>
In-Reply-To: <CAL_Jsq+iVfFGYEF575spQ5MaYPzo1QSfLUZP1M=TpH0+HdGS6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

On 11/10/2014 05:14 PM, Rob Herring wrote:

>> __earlycon_of_table_sentinel.compatible is a char[128], not a pointer, so
>> it will never be NULL.  Checking it against NULL causes the match loop to
>> run past the end of the array, and eventually match a bogus entry, under
>> the following conditions:

>>   - Kernel command line specifies "earlycon" with no parameters
>>   - DT has a stdout-path pointing to a UART node
>>   - The UART driver doesn't use OF_EARLYCON_DECLARE (or maybe the console
>>     driver is compiled out)

>> Fix this by checking to see if match->compatible is a non-empty string.

>> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
>> Cc: <stable@vger.kernel.org> # 3.16+

> Thanks. I'll queue this up.

> BTW, you should not add stable CC when submitting for review, but
> rather add a note for the maintainer to apply to stable. Only if a
> commit is in mainline already and not flagged for stable, then you
> send the patch with the stable tag to get the commit added to stable.
> It's a bit confusing...

    It's actually OK to tag the patch for stable (not really send to stable), 
so that that list gets automatically notified when the comment lands in the 
mainline. Unless the maintainer doesn't have his own rules about stable 
patches (like e.g. DaveM). Do you have alike rules?

> Rob

WBR, Sergei
