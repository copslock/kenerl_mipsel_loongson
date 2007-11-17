Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Nov 2007 08:38:50 +0000 (GMT)
Received: from fk-out-0910.google.com ([209.85.128.188]:10117 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20022695AbXKQIim (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 17 Nov 2007 08:38:42 +0000
Received: by fk-out-0910.google.com with SMTP id f40so1151836fka
        for <linux-mips@linux-mips.org>; Sat, 17 Nov 2007 00:38:32 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=cVwj1yeFEOen8n81pOF7WtDtMwlrl6aK/Z4KhV5rZUU=;
        b=dShDS1VBemIXeWDC3J8obbIZrGdbqDHM+fVv+qDyfPilQ9tUiP9+/Piky8jWGDeXHhtRfs5+qTapkLnOlYcMMisIKX8aaxLWAV3ECX1R6WaW2BBwsESLiJlJWtTCc0CWoblfhvQnVVgyhKi8e7zYLcyjwS9lDYfNe7OAKK65mjc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ok7+Gp95N8Czvq/no1TZlML2noFz+5+52Ql/8B9Xd79AJAsWMSQrgPnPKP4FbO2CJnMn/DhDddBaSgbxHRz7HK5jJPpn3gUMOnPOo5ooo5yAnKGVPKGeWtWn1fM6MClcgfw3HAv1kJvuSAyZNM+UosQdLbHGFJS00aUZnANGz4s=
Received: by 10.86.62.3 with SMTP id k3mr2660278fga.1195288712214;
        Sat, 17 Nov 2007 00:38:32 -0800 (PST)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id c28sm5569458fka.2007.11.17.00.38.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Nov 2007 00:38:31 -0800 (PST)
Message-ID: <473EA885.80605@gmail.com>
Date:	Sat, 17 Nov 2007 09:38:29 +0100
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	David Daney <ddaney@avtrex.com>
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Cannot unwind through MIPS signal frames with	ICACHE_REFILLS_WORKAROUND_WAR
References: <473957B6.3030202@avtrex.com> <18233.36645.232058.964652@zebedee.pink> <20071113121036.GA6582@linux-mips.org> <473C0761.1040205@gmail.com> <20071115115351.GA4973@linux-mips.org> <473C8006.2070902@avtrex.com>
In-Reply-To: <473C8006.2070902@avtrex.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> I am liking the idea of putting the trampoline code in the (as of yet
> non-existent vdso).  This eliminates the need to flush the icache, but
> maintains the ability of user code to unwind through signal frames.
> 
> Putting a .eh_frame section in the vdso would be even better as that
> would eliminate the need for libgcc to do code reading and let the
> kernel use any means desired to return from signal handlers.
> 

You're very welcome to improve the ld script for VDSO generation, I
sent a couple days ago. I would be happy to integrate your
improvements in my patch for the future version.

thanks,
		Franck
