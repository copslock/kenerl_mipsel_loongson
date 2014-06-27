Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jun 2014 00:09:13 +0200 (CEST)
Received: from mail-ob0-f176.google.com ([209.85.214.176]:38754 "EHLO
        mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6856090AbaF0WJJ4MrB6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Jun 2014 00:09:09 +0200
Received: by mail-ob0-f176.google.com with SMTP id wm4so6230514obc.7
        for <multiple recipients>; Fri, 27 Jun 2014 15:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=MMGAVrxgNxhxSmhFUZ2cI2jckYP/ivo1vaXp70Czu04=;
        b=bQHHDoUIz8kSAiaCNMVkmqm2MOrgq5VIeCKiRnhgG0e3jY25Z4+rlywVMFfm1LKvDL
         b4Lk+b4cEyWnDGVvffW8wlsQdCS06gZOZ0lOaVNt7CqV8jGM1EeXiNUlpM/tqac4IV9f
         e3VDkPTi5VclgRyX1fXnmEONUPN6VHFBppmgXm6ElHMSdcK3akgoTS5P/NDdd4Yi7C0V
         E0dxvZylZrEl8iDo/Hi7vmHwEgTF1kZHZs4kFp5MSnmm4ZrgQMxDmPKaU7f9lMR9oTBx
         XMWwrZPtJ03Yof9Tu7zL2FWulJwVmUAAReQ6kb2EkDXm/uPey+Pz5kmmlxzatk+aTxvo
         gV0Q==
X-Received: by 10.60.103.206 with SMTP id fy14mr26410603oeb.21.1403906943424;
 Fri, 27 Jun 2014 15:09:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.9.82 with HTTP; Fri, 27 Jun 2014 15:08:23 -0700 (PDT)
In-Reply-To: <20140510214050.GA9616@ugly.fritz.box>
References: <20140510214050.GA9616@ugly.fritz.box>
From:   Florian Fainelli <florian@openwrt.org>
Date:   Fri, 27 Jun 2014 15:08:23 -0700
X-Google-Sender-Auth: IYP-ZKGDhWSfHFM8WNRWSiiMIrM
Message-ID: <CAGVrzca5MQa8FRO7yyjJrteCxy4vCBBLfrxS=63S7bLdAqVZrg@mail.gmail.com>
Subject: Re: misp/ar7 serial port fix
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

2014-05-10 14:40 GMT-07:00 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>:
> moin,
>
> while trying to get openwrt with a 3.10 kernel on my ar7-based dsl
> modem, i ran into a "serial console goes blank after handing over from
> the boot console" style bug, almost identical to
> https://dev.openwrt.org/ticket/3123 and
> https://dev.openwrt.org/ticket/6532 by appearances.
> in fact, it seems the port was forgotten when something was
> restructured in the higher level stuff. i didn't bother to investigate
> beyond that ...

Your patch looks correct to me. Could you make it a formal submission
and send it to linux-mips such that Ralf can apply it?

Thanks!
-- 
Florian
