Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Apr 2009 10:00:55 +0100 (BST)
Received: from qw-out-1920.google.com ([74.125.92.147]:14045 "EHLO
	qw-out-1920.google.com") by ftp.linux-mips.org with ESMTP
	id S20022852AbZDTJAr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Apr 2009 10:00:47 +0100
Received: by qw-out-1920.google.com with SMTP id 9so885983qwj.54
        for <linux-mips@linux-mips.org>; Mon, 20 Apr 2009 02:00:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=rjkn4ibiQzeUH6K0h/0P7skkDfI7n12gfPXyh4IYg1E=;
        b=RlBGQhTvk+9gmLbhP01P2xfb3CZxg0d3bAJrFpABIg9mDlDKnMnPgMyxpfSEo8uVJJ
         wAN4Omo3orgLvJy9lmKuJADIC3KhiKHNYugiYhhBv1Ey55Laj/deurCCl3Ci9LSQ3uQU
         3R14w5JaaJw2n/8II0afeh4wV/KocFYdVzI10=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=BftIHwDxPHfo8iOVuuozsRegZnkVUra5J37wwz3SiCIFNPCdq9Ahnm1FTp9YB0nlxI
         9vx1Fr4p0lua13psMvfrToFIeuGU/fAHdtUqenkRVue2M+Q4AjqOpkhARVyBhvtgcQtI
         HLxYELpYBAt0dZjCWUXK6OT3gTshz8wQs/5Q4=
Received: by 10.220.45.135 with SMTP id e7mr5560695vcf.7.1240218043734;
        Mon, 20 Apr 2009 02:00:43 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 9sm7086739yxs.23.2009.04.20.02.00.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Apr 2009 02:00:43 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	nagalakshmi veeramallu <lucky.veeramallu@gmail.com>
Subject: Re: in mips how to change the start address to the new second boot loader  ?
Date:	Mon, 20 Apr 2009 11:00:38 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org
References: <d77cedf30904142309na4355e6w63ecea63b0966c92@mail.gmail.com>
In-Reply-To: <d77cedf30904142309na4355e6w63ecea63b0966c92@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200904201100.39164.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi,

Le Wednesday 15 April 2009 08:09:01 nagalakshmi veeramallu, vous avez écrit :
> Hi ,
>  I have a KMC board with mips VR4131 processor. The target board already
>  having cmon boot loader on flash. Now I need to put my yamon boot loader
>  which I modified according to the requirement on the flash. As we know
> MIPS have fixed starting address 0xbfc00000, how to change this address to
> other address so that after power on it can enter to the new address (boot
> loader).

You cannot indeed change the boot address, but you can place a routine, or 
even a bootloader at 0x1fc00000 which jumps to an arbitrary address.
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
