Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Oct 2009 09:27:19 +0100 (CET)
Received: from mail-bw0-f221.google.com ([209.85.218.221]:33244 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492839AbZJ2I1M (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 Oct 2009 09:27:12 +0100
Received: by bwz21 with SMTP id 21so1916112bwz.24
        for <linux-mips@linux-mips.org>; Thu, 29 Oct 2009 01:27:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=/Q9vrteFRVsSZbjhYQWyCcq7dws658gDsT2HMDk8yTo=;
        b=czzOqxGGYZIw3PgFcHWtimGwqMeOGJIIEio8oRHjKn9ZXMM82+oDOA6lAiQI3M8wpj
         mvlhMvhhOQnJ7Am/i3ypNivLBSAAYVpl5FDa/4nk6bgm4pPtiEf+9Px+pqWIcpugoPb8
         UEimLcKJqUMzZau1S/33EHcRRJEYRhL4vIKfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=C/YPrWdsbVC/xE91YxTKqz0/m3k8uM8meJNO/LuBkFjrxuSOM9h+clTmxJCJoTu6It
         Dc6hJjZGKIM9sfLH2B/54yJO4w1sXKT6HkxIgHqznaykWPHE+lXevLYVfBBPMm3IMsjs
         Jg7FYr8gT4mMRFw8vTSUNnqjUV54iNUWcREuo=
Received: by 10.103.87.33 with SMTP id p33mr7957154mul.94.1256804825871;
        Thu, 29 Oct 2009 01:27:05 -0700 (PDT)
Received: from pixies.home.jungo.com (pptp-il.jungo.com [194.90.113.98])
        by mx.google.com with ESMTPS id s10sm7732328muh.24.2009.10.29.01.27.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 01:27:05 -0700 (PDT)
Date:	Thu, 29 Oct 2009 10:26:52 +0200
From:	Shmulik Ladkani <jungoshmulik@gmail.com>
To:	myuboot@fastmail.fm
Cc:	"Sergei Shtylyov" <sshtylyov@ru.mvista.com>,
	"Florian Fainelli" <florian@openwrt.org>,
	linux-kernel@vger.kernel.org,
	"linux-mips" <linux-mips@linux-mips.org>, shmulik@jungo.com
Subject: Re: serial port 8250 messed up after coverting from little endian
 to big endian on kernel  2.6.31
Message-ID: <20091029102652.76d42b8c@pixies.home.jungo.com>
In-Reply-To: <1256758575.4093.1342456105@webmail.messagingengine.com>
References: <1255735395.30097.1340523469@webmail.messagingengine.com>
	<4AD906D8.3020404@caviumnetworks.com>
	<1255996564.10560.1340920621@webmail.messagingengine.com>
	<200910200817.24018.florian@openwrt.org>
	<1256676013.24305.1342273367@webmail.messagingengine.com>
	<20091028103551.0b4052d8@pixies.home.jungo.com>
	<4AE82520.4090607@ru.mvista.com>
	<1256758575.4093.1342456105@webmail.messagingengine.com>
X-Mailer: Claws Mail 3.7.3 (GTK+ 2.18.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <jungoshmulik@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jungoshmulik@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 28 Oct 2009 14:36:15 -0500 myuboot@fastmail.fm wrote:
> I just tried UPIO_MEM32 without adding a offset of 3. But the result is
> bad - after the kernel initializes the serial console, the console print
> out messes up. The early printk is fine because the u-boot initialises
> the serial port fine. 
> 
> Did I miss anything? Thanks again for your help.

I guess you did fine with UPIO_MEM32.

Keeping the UPIO_MEM32 approach, I suggest also to fiddle Y/N with
CONFIG_SWAP_IO_SPACE (might be that you have it set to Y while you don't
really need it, or vice versa).
This is since 'readl' uses 'ioswabl' for (potential) byte-swapping of the read
value. Take a look at asm/io.h and mangle-port.h.

Most important, read your hardware documentation to determine correct access
to the memory mapped serial registers.

-- 
Shmulik Ladkani		Jungo Ltd.
