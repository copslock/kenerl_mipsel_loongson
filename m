Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2007 16:35:03 +0000 (GMT)
Received: from wr-out-0506.google.com ([64.233.184.227]:45726 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022923AbXCTQfA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Mar 2007 16:35:00 +0000
Received: by wr-out-0506.google.com with SMTP id i31so1868587wra
        for <linux-mips@linux-mips.org>; Tue, 20 Mar 2007 09:33:55 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=VujjhrGphK6QwyzLDgeJ0pGPaHT3JogVwwC2d34qSGsPkPw8xg0CK4KaldLdX2nyr+08rUuPMKuZctGct+6cB61q1NkWTiGxo6GeqD5SB35YCRjJmLCl4EpWzDd+DR2wjv0ZUYsSIbD4bOSSaDLk2SRrNhotsyz8BsalJTvrgP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=eln7Y9wQ60mcoyHj+UQrqeJfne5m7FUdYocCYcrUsVtjBWz/yEkIBTGIBzy++pjkmhXa5UAmUyU6HgMbi+AKj+gbvLUk071PMoaTYWFrjIQ8YhN6pIZ1SOj1TC9wS0YiltpVanptLDG6Fjn3Xbb09Cwn2/bYBF6+BVuNcICnXK8=
Received: by 10.100.178.7 with SMTP id a7mr5202176anf.1174408434846;
        Tue, 20 Mar 2007 09:33:54 -0700 (PDT)
Received: by 10.114.159.16 with HTTP; Tue, 20 Mar 2007 09:33:54 -0700 (PDT)
Message-ID: <d459bb380703200933w501736cfmfbd19cc1b03f8ed1@mail.gmail.com>
Date:	Tue, 20 Mar 2007 17:33:54 +0100
From:	"Marco Braga" <marco.braga@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: Au1500 and TI PCI1510 cardbus
In-Reply-To: <46000ADD.3050309@ru.mvista.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_185849_28748522.1174408434653"
References: <d459bb380703190755n3f05b8e1v850bb8347e574d68@mail.gmail.com>
	 <200703200204.l2K24WgH020041@centurysys.co.jp>
	 <45FFEDED.6060708@ru.mvista.com>
	 <d459bb380703200747y13ba427ek83cc32b503c33bc7@mail.gmail.com>
	 <45FFFE8B.1010806@ru.mvista.com>
	 <d459bb380703200850m1077be9cnecb8283750763a4f@mail.gmail.com>
	 <4600052B.40901@ru.mvista.com>
	 <d459bb380703200908t2ab759f0u352dc0014ebe0b17@mail.gmail.com>
	 <46000ADD.3050309@ru.mvista.com>
Return-Path: <marco.braga@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marco.braga@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_185849_28748522.1174408434653
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

To sum it up, Cardbus bridge is not a viable solution on Au1500 for
hotswapping devices, since any decent one (bus mastering) will not work.
USB2.0 should instead work with PCI based controllers, that must be
connected to the main PCI device (directly to Au1500).

Well, I think that this closes the issue. As a last note, Au1200 is not a
solution since we really need PCI.

I'd like to thank everyone here, you've been very patient with me. :-)

Regards,
Marco

------=_Part_185849_28748522.1174408434653
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

To sum it up, Cardbus bridge is not a viable solution on Au1500 for
hotswapping devices, since any decent one (bus mastering) will not
work. USB2.0 should instead work with PCI based controllers, that must
be connected to the main PCI device (directly to Au1500).<br>
<br>
Well, I think that this closes the issue. As a last note, Au1200 is not a solution since we really need PCI.<br><br>I&#39;d like to thank everyone here, you&#39;ve been very patient with me. :-)<br>
<br>
Regards,<br>
Marco<br>
<br>

------=_Part_185849_28748522.1174408434653--
