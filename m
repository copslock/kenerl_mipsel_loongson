Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Mar 2007 23:13:39 +0000 (GMT)
Received: from wr-out-0506.google.com ([64.233.184.231]:19232 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022359AbXCMXNf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Mar 2007 23:13:35 +0000
Received: by wr-out-0506.google.com with SMTP id i31so2778753wra
        for <linux-mips@linux-mips.org>; Tue, 13 Mar 2007 16:12:34 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=PoRQYsWj20u2AyI7oZbeRbOmK/Dz8j40wIhliVBq0cN9yfawHx495b19g1mxc5+mYEkekmpypMdgMdiEZ10cqRpwmQggdxSj4UA1B4TUpheHuBcaWVtJFPcoW7CBvrVnBHzhnjOb+Yf2q5HhEnAkEK6aHEX5/hEKr0jvZ7uUjNM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=oKkNvCNz1NgF/wEjYVK33Sdcs5Mm0ddV2nejd6gs6Hy+jO5PmmIz9hmcQldLojvB9gd3JKJmzkkd+Gm7Xijbw9hBfhF696grEY0m/hCK442iaZPG0RPAOSHoq465DoK97uPigT4AhWuBDBE05z8u/ZjIG4GYEdiy/MQGnPBOnwE=
Received: by 10.114.190.6 with SMTP id n6mr2651554waf.1173827554077;
        Tue, 13 Mar 2007 16:12:34 -0700 (PDT)
Received: by 10.114.159.16 with HTTP; Tue, 13 Mar 2007 16:12:34 -0700 (PDT)
Message-ID: <d459bb380703131612m36c70ecaka83175b3d8a30bc5@mail.gmail.com>
Date:	Wed, 14 Mar 2007 00:12:34 +0100
From:	"Marco Braga" <marco.braga@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: Trouble with sound/mips/au1x00.c AC97 driver
In-Reply-To: <45F71FFD.202@cooper-street.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_41942_31568767.1173827554009"
References: <20070307104930.GD25248@dusktilldawn.nl>
	 <d459bb380703082322r18879381ma4c57149a8b7adfe@mail.gmail.com>
	 <45F350E9.3020208@cooper-street.com>
	 <d459bb380703120157wb3dde00p4c232e300e82fd3d@mail.gmail.com>
	 <d459bb380703120259r53889966xd8af623ff01ef297@mail.gmail.com>
	 <45F5DC73.9060004@cooper-street.com>
	 <d459bb380703130143w7c98e1cchdbdae6cb9a7ac7ce@mail.gmail.com>
	 <45F71FFD.202@cooper-street.com>
Return-Path: <marco.braga@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14461
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marco.braga@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_41942_31568767.1173827554009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Charles,

I do agree that my "fix" is not worth an official patch, not only because it
is inelegant but because we haven't found the exact cause of the problem. I
think at the moment we need to collect more reports, just to know if I am
the only one experiencing this issue. Tomorrow I'll post a message with a
small cut&paste of the piece of code I've changed, as a reference if some
other person encounters the same problem. As a final notice, the 200ms delay
is not noticeable at all. The overall boot time is almost the same, and the
installing time of the module is less than a second.

I'd like to thank you all people for the support and help.

------=_Part_41942_31568767.1173827554009
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Charles,<br><br>I do agree that my &quot;fix&quot; is not worth an official patch, not only because it is inelegant but because we haven&#39;t found the exact cause of the problem. I think at the moment we need to collect more reports, just to know if I am the only one experiencing this issue. Tomorrow I&#39;ll post a message with a small cut&amp;paste of the piece of code I&#39;ve changed, as a reference if some other person encounters the same problem. As a final notice, the 200ms delay is not noticeable at all. The overall boot time is almost the same, and the installing time of the module is less than a second.
<br><br>I&#39;d like to thank you all people for the support and help.<br><br>

------=_Part_41942_31568767.1173827554009--
