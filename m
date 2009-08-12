Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Aug 2009 11:20:01 +0200 (CEST)
Received: from ey-out-1920.google.com ([74.125.78.145]:4143 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492114AbZHLJT4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 12 Aug 2009 11:19:56 +0200
Received: by ey-out-1920.google.com with SMTP id 13so4569eye.54
        for <linux-mips@linux-mips.org>; Wed, 12 Aug 2009 02:19:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=tMdjKw7SFVwt7WR9GKY3Ncj1ZgbgcTPkaot9moRrWeE=;
        b=UaPgiEOjSb1qCXR6vPenPrKAR1ajK4d0liOVps6LgouvosVRApkaVwhGAbEMSFbtr4
         cxkbV9AaeRSbahTXH9tpSwFCLi9mSWw3LiZPV9WFX/HBYzW+AcUcvqB8qI6hMjYLdtHF
         qrA7gvv6CkTIzR7ACrLJVO/qLZx3Ly0AjbgSM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=s8JhetwAgrGEOXkMUR83zdiypXhYMmsLI65UWBsWWn8XogTJl56pnmM9R2lo0Epyus
         IQXSQvVpACVgYx5lM0+KWWM5oQ3tvJBHL1PDBT7NiFpCwBCuXgDacC0ZRcw1H3ErFsAj
         bjyCWGwCkRg+2jy394adGOHcbX+rai5Haa1do=
Received: by 10.210.20.10 with SMTP id 10mr2183228ebt.72.1250068795397;
        Wed, 12 Aug 2009 02:19:55 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 7sm2162415eyb.50.2009.08.12.02.19.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 Aug 2009 02:19:53 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Alexander Clouter <alex@digriz.org.uk>
Subject: Re: AR7 runtime identification [was:- Re: [PATCH -v1] MIPS: add support for gzip/bzip2/lzma compressed kernel images]
Date:	Wed, 12 Aug 2009 11:19:44 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org
References: <1249894154-10982-1-git-send-email-wuzhangjin@gmail.com> <200908112319.58367.florian@openwrt.org> <gibal6-mt3.ln1@chipmunk.wormnet.eu>
In-Reply-To: <gibal6-mt3.ln1@chipmunk.wormnet.eu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200908121119.48135.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Wednesday 12 August 2009 10:37:04 Alexander Clouter, vous avez écrit :
> Florian Fainelli <florian@openwrt.org> wrote:
> >> Le Monday 10 August 2009 12:12:05 Alexander Clouter, vous avez écrit :
> >>
> >> For your information, the TNETD7300GDU is detected like this:
> >> TI AR7 (TNETD7300), ID: 0x0005, Revision: 0x02
> >>
> >> and the TNETD7300EZDW (ADSL 2+) is detected like this:
> >> TI AR7 (TNETD7200), ID: 0x002b, Revision: 0x10 which also has the UART
> >> bug and is wrongly detected as a TNETD7200.
> >>
> >> I have left the WAG54G at work and will get my hands back on it tomorow.
> >
> > The bad news is that my WAG54G v2 which is also a TNEDT7300GDU has this
> > HW bug too rendering the runtime detection of the bug more difficult.
>
> Well, two options I guess.  Another Kconfig or pass something
> on the command line to the kernel.  I would opt for the latter as the
> bug does not make the machine completely unusable and if you make sure
> the workaround is disabled by default hopefully that will have the
> effect of getting people to contact you to add an extra data point.

Or simply enable the workaround even for sane hardware like it is done here: 
https://dev.openwrt.org/browser/trunk/target/linux/ar7/patches-2.6.30/500-serial_kludge.patch 
as this patch has no side effect on working hardware.

>
> Annoyingly I'm guess we are more interested in people who do *not* have
> the bug and we would not hear from them as a result.  Maybe if we
> proactively crippled their serial port.... :)
>
> Cheers
> --  
Cordialement, Florian Fainelli
------------------------------
-- 
Best regards, Florian Fainelli
Email: florian@openwrt.org
Web: http://openwrt.org
IRC: [florian] on irc.freenode.net
-------------------------------
