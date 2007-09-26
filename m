Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2007 15:29:33 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.174]:30393 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20029710AbXIZO3Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Sep 2007 15:29:24 +0100
Received: by ug-out-1314.google.com with SMTP id u2so1307654uge
        for <linux-mips@linux-mips.org>; Wed, 26 Sep 2007 07:29:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=6hjJRoVPW9V9uVjlc2yVyN6+PxGbki9KPHCAWKsmO6U=;
        b=Dvy7L8wx7k9nbdsdeAfejzBGVNKfn1szskCFmeU09sTb9osMMuK0UcaXkKuX+Zrm3RZsQBGVWSVetgBeOQk7t14JLJ2Xh6gUjG7jMxRpQIe9B56OuZt7En9pp59QLxLrHkYK4sam5CAomik29Mf3NtsTdhRoA6NC38WBIIBxN5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=o8hA7W8YIx9KfKSuV9H50aZ1QMluezDUlCI+w3RP2nDhBrs3cMTblteBd2R1NuRBxne+wTeVKbKAonPGSeihWz+B0ZWUs8WC7nsgnp297DD1mc1KuFAiVN7gcJe7coDihZ7oyfIDWI7y9TEwiUj3IJStvBM7dQYlYaYR4cV95Q0=
Received: by 10.67.26.7 with SMTP id d7mr2246217ugj.1190816946336;
        Wed, 26 Sep 2007 07:29:06 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id f31sm1780147fkf.2007.09.26.07.29.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Sep 2007 07:29:05 -0700 (PDT)
Message-ID: <46FA6C3F.6090605@gmail.com>
Date:	Wed, 26 Sep 2007 16:27:11 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Markus Gothe <markus.gothe@27m.se>
CC:	Ralf Baechle <ralf@linux-mips.org>, nigel@mips.com,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Useless stack randomization patch
References: <46FA6846.2080704@gmail.com> <46FA6B27.6050204@27m.se>
In-Reply-To: <46FA6B27.6050204@27m.se>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Markus Gothe wrote:
> I think you mean this in specific:
> 
> "/* This yields a string that ld.so will use to load implementation
>    specific libraries for optimization.  This is more specific in
>    intent than poking at uname or /proc/cpuinfo.
> 
>    For the moment, we have only optimizations for the Intel generations,
>    but that could change... */
> 
> #define ELF_PLATFORM  (NULL)"
> 
> Right?
> 

Correct...

		Franck
