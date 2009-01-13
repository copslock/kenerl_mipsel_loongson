Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2009 17:31:02 +0000 (GMT)
Received: from mail-bw0-f13.google.com ([209.85.218.13]:55778 "EHLO
	mail-bw0-f13.google.com") by ftp.linux-mips.org with ESMTP
	id S21103555AbZAMRa4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Jan 2009 17:30:56 +0000
Received: by bwz6 with SMTP id 6so382548bwz.0
        for <linux-mips@linux-mips.org>; Tue, 13 Jan 2009 09:30:50 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=16FP2KSxRW74YuLo3Fr9ke/aMPgHh8JgsuvF94kVkCs=;
        b=qR/uuUjqkEPDmM2De0nsaQDqU5ALN2wxZeIU+8tOggoMWZhmYeByHepU+AHSMZgP3n
         uKHCRyaMAgqJBLrCqFxS6+3LHrnxm9vuvnqiDqA3tDt5ApK5qSOsVJ/qc+GbhAd4p4e4
         A+HFp4hELaCml6v+j2BJXF8/HU4dEZxSC/v1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=mleboKyxVJxUfaKsNt8nVkhnSotZAe2OGKdl5CMezKixL5aRVv6uyB2ca+YAOo5PH1
         QrBROcyA7WJ1JATmvLWEs5CGOo0pwi7Mvf2g+XmG44XzlU3Hbuih9Gagd3xvinXdV1e9
         0m6O4RPuA4C68FIIWyJanv6NVkZwVTp9osrxo=
Received: by 10.103.245.18 with SMTP id x18mr11413270mur.62.1231867848086;
        Tue, 13 Jan 2009 09:30:48 -0800 (PST)
Received: from flowlan.maisel.int-evry.fr ([157.159.47.25])
        by mx.google.com with ESMTPS id n7sm17217050mue.54.2009.01.13.09.30.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Jan 2009 09:30:47 -0800 (PST)
From:	Florian Fainelli <florian@openwrt.org>
To:	Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
Subject: Re: [pnx833x_port]: device name prefix - ttyS or ttySA?
Date:	Tue, 13 Jan 2009 18:30:31 +0100
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org
References: <1231859270.25974.32.camel@EPBYMINW0568>
In-Reply-To: <1231859270.25974.32.camel@EPBYMINW0568>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200901131830.32900.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi,

Le Tuesday 13 January 2009 16:07:50 Ihar Hrachyshka, vous avez écrit :
> In 'drivers/serial/pnx833x_port.c' we define the prefix for UART serial
> device as "ttyS". Anyway, we use major:minor numbers for SA1100 serial
> driver (that are 204:5). Why don't we use "ttySA" prefix then? That's
> what different embedded build systems expect for populating /dev (f.e.
> buildroot).

In my experience, everything that is not ttyS is a bit confusing either when 
creating the devices in the roots, or when using the serial console in the 
kernel command line. So I will vote for ttyS.

My 2 cents.
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
