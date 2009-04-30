Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Apr 2009 22:38:51 +0100 (BST)
Received: from mail-qy0-f171.google.com ([209.85.221.171]:61777 "EHLO
	mail-qy0-f171.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20026769AbZD3Vio (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Apr 2009 22:38:44 +0100
Received: by qyk1 with SMTP id 1so4198004qyk.22
        for <linux-mips@linux-mips.org>; Thu, 30 Apr 2009 14:38:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=8q4r6ncTdwabR6lOdiXFiw4Z2L+usRJ5KRImV1K8TXE=;
        b=d0XRoahthiwJ9Lxhd13i3hdM8NvS1FVrNw0HgYW26o+uMZyVowj10KQLhSkgESq8fV
         LWvH0eAsFoPwlyg+mdtWa4r4uJOd6vtu/7zjpuZSUpXmXNvbedzECsNdCHkOCXHzwcRS
         JJ2jlMe6fZnxGSdAt19fLKlo3DyyqRWSpa/Kk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=s01KdxWKanPfQLFDeSFhccaoIVOLNscxtsXmrxRJiQWQrGSlyejPC80IPDC5qIM922
         5dBo80Ltb9wsRbjOP+kRmg51Vbux3THuqIw6ZgRBdaOc2/lEgpOCX7fxj9mHMH85926i
         GRKF2cwVKZgvc/5CHPazUebCmIG6L1HOxlwgI=
MIME-Version: 1.0
Received: by 10.220.96.3 with SMTP id f3mr4288452vcn.24.1241127517882; Thu, 30 
	Apr 2009 14:38:37 -0700 (PDT)
In-Reply-To: <49F85EDF.1060002@wp.pl>
References: <ecbbfeda0904280458s4bb2de2q6c629ed79a472adc@mail.gmail.com>
	 <200904281501.37811.florian@openwrt.org>
	 <ecbbfeda0904281012h33f3a572nbd11547d5964c19d@mail.gmail.com>
	 <49F749FE.8050808@wp.pl> <49F74BE9.30004@wp.pl>
	 <ecbbfeda0904281805l21118b94uf7889df3171b4ba7@mail.gmail.com>
	 <49F85EDF.1060002@wp.pl>
Date:	Thu, 30 Apr 2009 16:38:37 -0500
Message-ID: <ecbbfeda0904301438l3d5488b5p15fff05016445852@mail.gmail.com>
Subject: Re: Linux on Linksys PSUS4?
From:	Andrew Wiley <debio264@gmail.com>
To:	"W.P." <laurentp@wp.pl>, linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=0016e64ec392d30a7d0468cc84d0
Return-Path: <debio264@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22575
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: debio264@gmail.com
Precedence: bulk
X-list: linux-mips

--0016e64ec392d30a7d0468cc84d0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Well, I've got everything I need set up, but now I've hit the problem of
actually flashing it. I was counting on using the normal Linksys tftp
flashing method, but I can't get a tftp response from the printserver. Could
I be missing something there?
Besides that... serial was discarded as impractical and I don't have JTAG
schtuffs (but how hard would it be to do that?).
Oh, and I'm pretty sure flashing it straight through Linksys's web interface
is out of the question.
I may be trying to do the impossible here, but how could/should I procede?

Andrew Wiley

--0016e64ec392d30a7d0468cc84d0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Well, I&#39;ve got everything I need set up, but now I&#39;ve hit the probl=
em of actually flashing it. I was counting on using the normal Linksys tftp=
 flashing method, but I can&#39;t get a tftp response from the printserver.=
 Could I be missing something there?<br>
Besides that... serial was discarded as impractical and I don&#39;t have JT=
AG schtuffs (but how hard would it be to do that?).<br>Oh, and I&#39;m pret=
ty sure flashing it straight through Linksys&#39;s web interface is out of =
the question.<br>
I may be trying to do the impossible here, but how could/should I procede?<=
br><br>Andrew Wiley<br>

--0016e64ec392d30a7d0468cc84d0--
