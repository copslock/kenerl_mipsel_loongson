Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2007 07:33:47 +0000 (GMT)
Received: from wx-out-0506.google.com ([66.249.82.234]:925 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022080AbXCTHdn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Mar 2007 07:33:43 +0000
Received: by wx-out-0506.google.com with SMTP id t14so1674968wxc
        for <linux-mips@linux-mips.org>; Tue, 20 Mar 2007 00:32:35 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=qedBXKKq42Jmxhym4yNoTu6gcLVHLfYWhvioGwkCjF8mE0tx9IiR1//rWXAEOsW7gzi9caIBDNjtWGbmaCCIZHw2HNdnA0k+iZMxd+ERp2Ikc7CoKv3H7qemNt1H7pDi/THjp+a7PRO0kWIjGx0XFjFTm20uq2YtRSyzzOdd5+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=Hzep5yvWqnRJvzqdY3EmfcssCgKw4oXEQFNI/24Y0QWoq9MOiaRSWB2lbFq+7szlbajYLgRsD9eXB/9Wg0SUl9tCdtgNiMWp1FTqJy4NTI7S7tfKHcvnyzMpYp+mQA4WM1q4PX9AO2wZr+uq0qgtzqnA8jeJuGErrcTE3HtYM+E=
Received: by 10.70.32.13 with SMTP id f13mr10200294wxf.1174375955165;
        Tue, 20 Mar 2007 00:32:35 -0700 (PDT)
Received: by 10.114.159.16 with HTTP; Tue, 20 Mar 2007 00:32:34 -0700 (PDT)
Message-ID: <d459bb380703200032s16993f87s89cd057d8b4ec2c6@mail.gmail.com>
Date:	Tue, 20 Mar 2007 08:32:34 +0100
From:	"Marco Braga" <marco.braga@gmail.com>
To:	"Takeyoshi Kikuchi" <kikuchi@centurysys.co.jp>
Subject: Re: Re: Au1500 and TI PCI1510 cardbus
Cc:	linux-mips@linux-mips.org
In-Reply-To: <200703200204.l2K24WgH020041@centurysys.co.jp>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_174624_15467755.1174375954942"
References: <d459bb380703190755n3f05b8e1v850bb8347e574d68@mail.gmail.com>
	 <200703200204.l2K24WgH020041@centurysys.co.jp>
Return-Path: <marco.braga@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14581
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marco.braga@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_174624_15467755.1174375954942
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello!

2007/3/20, Takeyoshi Kikuchi <kikuchi@centurysys.co.jp>:

Our Au1500 board works fine with Ricoh CardBus Bridge and NEC USB
> controller.
> However, the board does not work stably with TI PCI1520 controller.


As you have seen, we've experienced the same problem with the PCI1510. Can
you please give me the exact product number of both the controllers you use
(USB / Cardbus)? In particular your cardbus experience is interesting
because from the informations I've received until now I tought that no
cardbus controller could work on Au1500's PCI.

Thanks!

------=_Part_174624_15467755.1174375954942
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello!<br><br><div><span class="gmail_quote">2007/3/20, Takeyoshi Kikuchi &lt;<a href="mailto:kikuchi@centurysys.co.jp">kikuchi@centurysys.co.jp</a>&gt;:<br><br></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Our Au1500 board works fine with Ricoh CardBus Bridge and NEC USB<br>controller.<br>However, the board does not work stably with TI PCI1520 controller.</blockquote><div><br>As you have seen, we&#39;ve experienced the same problem with the PCI1510. Can you please give me the exact product number of both the controllers you use (USB / Cardbus)? In particular your cardbus experience is interesting because from the informations I&#39;ve received until now I tought that no cardbus controller could work on Au1500&#39;s PCI.
<br><br>Thanks!<br><br></div></div><br>

------=_Part_174624_15467755.1174375954942--
