Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 14:43:32 +0000 (GMT)
Received: from wr-out-0506.google.com ([64.233.184.224]:23151 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021906AbXCSOn1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Mar 2007 14:43:27 +0000
Received: by wr-out-0506.google.com with SMTP id i31so1333192wra
        for <linux-mips@linux-mips.org>; Mon, 19 Mar 2007 07:42:20 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=nsjgzIzhr3g78MCLi98jqHD9TSGXTMevtAPDJy6PhZQRyxo0kXyoYmHQ7Hfmthoevz89xtgA0wY3oIuWFwltR7VI9oQe3fCt1/2fqpwjO0wAxJRA9CAnAXOPQWfsw1etHfjzf/pPeRtb7IEWXfGjzMUUrfr1E5TrSw4KJVcWL4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=mNxa4axs2Rkb4Y02U3n6Y4OHBb+Qq4L2B2hhEBE+5AW9/8raQpwa3mhBSGE6ljZE7+BL67e79RxNsUv7FDo6M+4ys0oXCgg+AoiSqRlvSmVE5/z3BuqVNLu5orRLni5OH/aeMnTmNOQpeY9rqPeyMlQ95iXIPtTbFbXTfhR8HPk=
Received: by 10.90.28.12 with SMTP id b12mr4037554agb.1174315338959;
        Mon, 19 Mar 2007 07:42:18 -0700 (PDT)
Received: by 10.114.159.16 with HTTP; Mon, 19 Mar 2007 07:42:18 -0700 (PDT)
Message-ID: <d459bb380703190742t2fcce3ecud110b1caa0725c86@mail.gmail.com>
Date:	Mon, 19 Mar 2007 15:42:18 +0100
From:	"Marco Braga" <marco.braga@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: Au1500 and TI PCI1510 cardbus
In-Reply-To: <45FE83B6.3040100@ru.mvista.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_154682_4768783.1174315338838"
References: <d459bb380703161129l769d3f48w744ba0bfdf04fc91@mail.gmail.com>
	 <45FBB9C7.9060800@cubic.org>
	 <d459bb380703170554l3fb40d60h6f68b70472ad7cb@mail.gmail.com>
	 <45FBF0F1.70302@cubic.org>
	 <d459bb380703180617i6e50539bx13ad405fb306fe44@mail.gmail.com>
	 <45FE83B6.3040100@ru.mvista.com>
Return-Path: <marco.braga@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14553
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marco.braga@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_154682_4768783.1174315338838
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

Michael sent me a more elaborate answer from AMD. It seems indeed that there
is no way to make the Cardbus work without locking. I think we'll try better
luck with USB 2.0. Regarding to this, has anyone had any success with EHCI
controllers and Au1500?

Thanks!

------=_Part_154682_4768783.1174315338838
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br><br>Michael sent me a more elaborate answer from AMD. It
seems indeed that there is no way to make the Cardbus work without
locking. I think we&#39;ll try better luck with USB 2.0. Regarding to this,
has anyone had any success with EHCI controllers and Au1500?
<br><br>Thanks!

------=_Part_154682_4768783.1174315338838--
