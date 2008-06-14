Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Jun 2008 22:08:34 +0100 (BST)
Received: from yw-out-1718.google.com ([74.125.46.152]:65240 "EHLO
	yw-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S28576060AbYFNVIc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 14 Jun 2008 22:08:32 +0100
Received: by yw-out-1718.google.com with SMTP id 9so2317921ywk.24
        for <linux-mips@linux-mips.org>; Sat, 14 Jun 2008 14:08:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=arwXr2eAbzjpuHXkANg+7BJexQh68QcQ5Z9Mzixd9Lg=;
        b=DtAEStEjprSehdzhwYpeZPmXJKKVsvKwjmmDmw1xmNnTVvXT2B6vNScssN1rsnK6EN
         mGe/Y6l7Uw+5UnN7N7TQYEy9X7lUbRv9y+xJqWgU3uQ/37UHxhbc7mIERxML2fa0axDN
         DaISokup2gSnKsOPeLYxJgh0sLjcye+lLbt9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=GjJFl7swHc04nsxBG5KrjxRhUfek5JIcopS+BFlIWYtUj6cahU4DhYRSKjR3Jvncqr
         fwFRZ5k1eO05Hu7FPl5NevKY/UrMZ4pFjSmWBHRghKOXOZsZKHQnxNcuy9xArBuLfyEW
         bsHwhijs+EJU+sz2hRqGIRGWFzVKuXqU7QRYg=
Received: by 10.150.198.20 with SMTP id v20mr7281377ybf.151.1213477709986;
        Sat, 14 Jun 2008 14:08:29 -0700 (PDT)
Received: by 10.150.190.7 with HTTP; Sat, 14 Jun 2008 14:08:27 -0700 (PDT)
Message-ID: <5d932cdc0806141408y5d5407e8oab329686ecb25566@mail.gmail.com>
Date:	Sat, 14 Jun 2008 22:08:27 +0100
From:	"Thomas Horsten" <thomas@horsten.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [BUG] R5000 failure in kmap_coherent on Lasat board, bug that has been there for a while?
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20080614125903.GA483@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.40.0806131600540.25629-100000@jehova.dsm.dk>
	 <20080614125903.GA483@linux-mips.org>
X-Google-Sender-Auth: 52138f530609f578
Return-Path: <thomas.horsten@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas@horsten.com
Precedence: bulk
X-list: linux-mips

2008/6/14 Ralf Baechle <ralf@linux-mips.org>:

> Only compile tested - can you try this one?

Looks like it did the trick! Well done, Jedi Master!

// Thomas
