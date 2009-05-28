Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2009 12:32:02 +0100 (BST)
Received: from mail-bw0-f177.google.com ([209.85.218.177]:37591 "EHLO
	mail-bw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024381AbZE1Lbz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 May 2009 12:31:55 +0100
Received: by bwz25 with SMTP id 25so5526678bwz.0
        for <multiple recipients>; Thu, 28 May 2009 04:31:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=3hrufnDb8ODh/hfc9DHmEJ+4zGfZqAv09hEFnF0oJh4=;
        b=xfbBVaD60Y53QIY4uVm2n++kGgi88nqk1JcXUMit0zjmWgxaC+rqKPT2eCQjKkOobF
         CMQO8kXBs2PxDmkQweeaW1b6csTTaaGhbJ8xLagrWmY/luDdKyVV/CbxQ1w3TuY1jknh
         gxvX5FS3Wj+fXmcxJMbsVwq7GJm/Dz6Zj32bI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=kLsmi9jlDyPIiZvmUXVTyVlTjc1Uc61H9jAwsKra6C3LdzlfVF+eRt0WqNchS75ybM
         hUJxyUAjR44Hc9W5XTbr99acBJWsRE094nNK0Gp7yd/5BGM1UaoQCKTm4yPLsVj95f5E
         ia3xV5Wfdj0dN3IQ66E6mzlwItiyR1GdKT1rM=
Received: by 10.204.64.136 with SMTP id e8mr1107764bki.46.1243510309629;
        Thu, 28 May 2009 04:31:49 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 35sm5800895fkt.20.2009.05.28.04.31.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 May 2009 04:31:46 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Richard Sandiford <rdsandiford@googlemail.com>
Subject: Re: [PATCH] MIPS: Handle removal of 'h' constraint in GCC 4.4
Date:	Thu, 28 May 2009 13:31:40 +0200
User-Agent: KMail/1.9.9
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	David Daney <ddaney@caviumnetworks.com>,
	linux-mips@linux-mips.org
References: <1229567048-19219-1-git-send-email-ddaney@caviumnetworks.com> <alpine.LFD.1.10.0812190041080.6463@ftp.linux-mips.org> <87wsdl63xv.fsf@firetop.home>
In-Reply-To: <87wsdl63xv.fsf@firetop.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200905281331.41440.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Saturday 27 December 2008 16:19:40 Richard Sandiford, vous avez écrit :
> "Maciej W. Rozycki" <macro@linux-mips.org> writes:
> > On Wed, 17 Dec 2008, David Daney wrote:
> >> This is an incomplete proof of concept that I applied to be able to
> >> build a 64 bit kernel with GCC-4.4.  It doesn't handle the 32 bit case
> >> or the R4000_WAR case.
> >
> >  The R4000_WAR case can use the same C code -- GCC will adjust code
> > generated as necessary according to the -mfix-r4000 flag.  For the 32-bit
> > case I think the conclusion was the only way to get it working is to use
> > MFHI explicitly in the asm.
>
> No, the same sort of cast, multiply and shift should work for 32-bit
> code too.  I.e.:
>
> 		usecs = ((uint64_t)usecs * lpj) >> 32;
>
> It should work for both -mfix-r4000 and -mno-fix-r4000.

Any updates on this ?
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
