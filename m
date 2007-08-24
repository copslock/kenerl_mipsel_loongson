Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Aug 2007 12:42:17 +0100 (BST)
Received: from nz-out-0506.google.com ([64.233.162.229]:22932 "EHLO
	nz-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20024516AbXHXLmI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Aug 2007 12:42:08 +0100
Received: by nz-out-0506.google.com with SMTP id n1so447831nzf
        for <linux-mips@linux-mips.org>; Fri, 24 Aug 2007 04:41:46 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=K5KmgNq+DDtr2t/i5N+ALeNzWPSs5V1rm8lR/HancLH3N9mlXdPZTJbVep8JTJBjYM8TIBareabJyk7qeuppDItPTx0OhzghXayviKV3+3jrXk8VUek/rDY59adCxe6h/f9iaIg+yACg+niZM6X1kH8z4NyI35EWHXBzsDpxzW4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=GXOqjXteXojw5iXTBnUhFM3ah2tUIsrAKhL9Y0DveK0qhEtEL6cPqM3+hfkQn0Yjd2Ax5ax6pLMlDC1Yt1Df/AdqqQIW1vsKbruk43FT0dKPCIJuoHhSDhgwvUNYHoMFbFSgVEGerVC7B+OQsIiruLdJjNAE4i9Lp707oVls6r0=
Received: by 10.65.139.9 with SMTP id r9mr5352925qbn.1187955706016;
        Fri, 24 Aug 2007 04:41:46 -0700 (PDT)
Received: from ?192.168.1.120? ( [77.250.112.35])
        by mx.google.com with ESMTPS id 6sm851550nfv.2007.08.24.04.41.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Aug 2007 04:41:42 -0700 (PDT)
Message-ID: <46CEC3E9.3020300@gmail.com>
Date:	Fri, 24 Aug 2007 13:41:29 +0200
From:	Sunil Amitkumar Janki <devel.sjanki@gmail.com>
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
MIME-Version: 1.0
CC:	linux-mips@linux-mips.org
Subject: Re: Kernel 2.6.23-rc3 build error
References: <46CB0876.5030508@gmail.com> <20070824110729.GA4321@linux-mips.org> <46CEC0C1.1080603@gmail.com> <20070824113424.GA28274@linux-mips.org>
In-Reply-To: <20070824113424.GA28274@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To:	unlisted-recipients:; (no To-header on input)
Return-Path: <devel.sjanki@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: devel.sjanki@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
>
> I'm only interested in the version of your crosscompiler, not the native
> one.
>
>   Ralf

It is a native compile on the Fu Long box, I have ported Slackware 12.0
to run on it.

  Sunil
