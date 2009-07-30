Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jul 2009 22:14:16 +0200 (CEST)
Received: from ey-out-1920.google.com ([74.125.78.144]:32259 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493732AbZG3UOK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Jul 2009 22:14:10 +0200
Received: by ey-out-1920.google.com with SMTP id 13so395982eye.54
        for <multiple recipients>; Thu, 30 Jul 2009 13:14:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=IAbgbRCJoWNYc1NADycyVpGUVTXe+WLmV1wlgip4nTQ=;
        b=HoR8z9c/+mLx+RjISxEPfzdM8nC7K70SSteqrhGaF1gg4WkEiWbtpl5ArS4lEXXGlM
         AyjwdnxM3+j2uGoSTIkDlFRWTSgdkCSqp39qdehyJwO+ziEnOBhpNiJczx4RMShnppMb
         e1jsyMk73n3RQ9J4J7YCTpgU0/qslrOjKr/k8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=gHw/czTNgeMaqyDAQdI9ZEcScxYWU4aSlnPrBJiwfpI74MdqFPxLGzonFvagg1Y87o
         OnkaVk34p1EQjUic5wPo8AbXPJ/0bA6YxPlOSYhtvpB1uvw4XgJnln8A4D4TUZuP/QNn
         lUjhx5Yj3fLxJx0IbmKQdCcOqtD+DVhxbq6m0=
Received: by 10.210.89.7 with SMTP id m7mr1926199ebb.77.1248984849900;
        Thu, 30 Jul 2009 13:14:09 -0700 (PDT)
Received: from ?192.168.254.2? (florian.mimichou.net [82.241.112.26])
        by mx.google.com with ESMTPS id 28sm635573eye.34.2009.07.30.13.14.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Jul 2009 13:14:08 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	David Miller <davem@davemloft.net>
Subject: Re: [PATCH 0/4] au1000_eth platform device/driver conversion
Date:	Thu, 30 Jul 2009 22:13:59 +0200
User-Agent: KMail/1.9.9
Cc:	sshtylyov@ru.mvista.com, ralf@linux-mips.org,
	manuel.lauss@googlemail.com, linux-mips@linux-mips.org,
	netdev@vger.kernel.org
References: <200907282300.07144.florian@openwrt.org> <4A71F8FD.3060002@ru.mvista.com> <20090730.131000.259116391.davem@davemloft.net>
In-Reply-To: <20090730.131000.259116391.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200907302214.00525.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi,

Le Thursday 30 July 2009 22:10:00 David Miller, vous avez écrit :
> From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Date: Thu, 30 Jul 2009 23:48:13 +0400
>
> >   Because they were only posted to linux-mips. And we didn't see #2 and
> >   #4 in linux-mips either.
>
> That's not going to work.
>
> You can't apply some of these patches to one tree, and some to
> the other.  That leaves the driver in a half-baked state in BOTH
> trees during the entire development period.

Sorry about that I did not want to "spam" netdev with MIPS specific bits as I 
know those specific changes would lead to a discussion for sure.

>
> So one of the two trees has to be chosen and all 4 patches added
> there, and there only.

Ok, I got to respin them to address some comments on the MIPS-side anyway and 
will not forget to CC netdev and you this time.
-- 
Best regards, Florian Fainelli
Email: florian@openwrt.org
Web: http://openwrt.org
IRC: [florian] on irc.freenode.net
-------------------------------
