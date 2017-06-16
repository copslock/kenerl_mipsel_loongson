Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 19:45:22 +0200 (CEST)
Received: from mail-qt0-x244.google.com ([IPv6:2607:f8b0:400d:c0d::244]:32985
        "EHLO mail-qt0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994825AbdFPRpQAVQWW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 19:45:16 +0200
Received: by mail-qt0-x244.google.com with SMTP id w1so11827135qtg.0;
        Fri, 16 Jun 2017 10:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dToX9QnETfn5zhRp6jo+t9x9arbjBPdpY2iBGgvn9pc=;
        b=Ih+jrH4J6qS/pTcRIujVWSJ/ID9hftiP6nQVfcYKE1COU97tfhqT9qIiwmtsZdKGH0
         7Bq2HQwDLbAdDTmkvsheOt+DtDQda9dkhqYARKkn3R7L4hWdIBnwuUlVUO0UhliEUiFC
         AyXCJQ8eeR4Xyz5enMWMc+jHQFZDfnX9+AblacXzJVQiudrjBn2QQZ2XDhZCTCHvdrHW
         Zvn+iOLTUhRo7OWrHQiWzJ5JsHnqi5PD0EXQYzD+P+MI6lO8JQrr9lQ2WutYHNUCM8UA
         kC1hFiJ64KTGkvfbUkWoD9dE6XQxcLLU4H1uxa9QrQEeVwRHcCWmf1MgLZPh7/gtbA5y
         Bu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dToX9QnETfn5zhRp6jo+t9x9arbjBPdpY2iBGgvn9pc=;
        b=KW1Z2eZLy1DYeCXAqKwODeie+bw6JxNzaUy2QlbKESLKHwpw0L/OsLbLCTeBVa4HZX
         LyILDKFBGDVrfDa1oyoKzmDipK/bXCtbnEmatoWvr8k/9hb/U9/bV7eMwbfQID9YohHe
         AZiS0hRnqeW8aVAM255cS+A+wcmn1tE6SwcyUy0jVNkjaHzJpd1EkMktcb+zXvVpkQvi
         MkUWOGYF0hwc1dG1j9STjRGdhLZqzmO0d0M7L2/CPDO8Fo3ixW/WAB4OfTngc7hNM3l/
         Ppk1YMCYqAu4i20MKs6rwi2jLgYSI/A0dBxw/ViySRLui0YScdGB7aagd+UnKoRTUJkf
         6Izg==
X-Gm-Message-State: AKS2vOyOsOLQLR1AIpSA3kZpuoKcxbrMmpGn3Mp7V+iiBuD3OZwCecSe
        45X1yiDn3ASAUw==
X-Received: by 10.55.127.199 with SMTP id a190mr14897424qkd.100.1497635110213;
        Fri, 16 Jun 2017 10:45:10 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id x78sm1865682qkb.44.2017.06.16.10.45.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jun 2017 10:45:09 -0700 (PDT)
Subject: Re: [PATCH] MIPS: Make individual platforms select
 ARCH_MIGHT_HAVE_PC_SERIO
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     linux-mips@linux-mips.org, msalter@redhat.com,
        dmitry.torokhov@gmail.com, Ralf Baechle <ralf@linux-mips.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20170605171033.15008-1-f.fainelli@gmail.com>
 <alpine.DEB.2.00.1706160249370.23046@tp.orcam.me.uk>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <1ccd3748-9b52-2b23-f686-df86d8be050d@gmail.com>
Date:   Fri, 16 Jun 2017 10:45:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1706160249370.23046@tp.orcam.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58530
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 06/15/2017 06:56 PM, Maciej W. Rozycki wrote:
> On Mon, 5 Jun 2017, Florian Fainelli wrote:
> 
>> Out of the many MIPS platforms only 3 appear to be actually using an
>> I8042 keyboard controller: SGI, JAZZ and LOOGSON64, remove
>> ARCH_MIGHT_HAVE_PC_SERIO from the top-level MIPS Kconfig symbol and move
>> it down to those platforms that need it.
> 
>  How did you determine that?  Malta for one not only has an SMSC FDC37M817 
> Super I/O Controller featuring an 8042-compatible core, but actual PS/2 
> keyboard and mouse connectors as well.

I was just grepping for i8042 in platform code to determine that, this
came after having SERIO accidentally enabled on my platform
(BMIPS_GENERIC) and seeing that it crashed badly and it annoyed the crap
out of me that MIPS had ARCH_MIGHT_HAVE_PC_SERIO for platforms that
don't need it.

Will come up with a v2 that includes malta, any other platforms for
which it's not obvious?
-- 
Florian
