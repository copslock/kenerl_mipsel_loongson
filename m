Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2007 20:53:58 +0000 (GMT)
Received: from wr-out-0506.google.com ([64.233.184.236]:60405 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022460AbXCWUx4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Mar 2007 20:53:56 +0000
Received: by wr-out-0506.google.com with SMTP id i31so1053481wra
        for <linux-mips@linux-mips.org>; Fri, 23 Mar 2007 13:52:53 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=emMlHm7KZEX7gFLKfeKf8XCgdQ/YuBQLW2eDoBe7WGCouS8wGGHQkU2xMOwYW8KSQT3pMJ6SmJUvPH0v3YT/wrhqog8KQjmSXV7YecibyCX0i3eAW/2/s1kTJ060iX0EDeScKR9e2w2WK8fq6HODzLEwoeadsvgm0nOVcbJsI0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bTxPWGwNZRFDHFedWSE6lQIgHv8HERy/VmV2FoxA/oocJ8v8IkivXsI4XYyYqQpPd0xTCWcPN63TEur7n/Xa6NRVLBZWhqdCx+sqZTYoFJP/dAZ8bT8W4qQRR3BzgCJX4rBB5o2VbPOv7lpz4PcrZEO7kE5v3gujnogSZ+SkM2Q=
Received: by 10.114.170.1 with SMTP id s1mr1398785wae.1174683170772;
        Fri, 23 Mar 2007 13:52:50 -0700 (PDT)
Received: by 10.114.136.11 with HTTP; Fri, 23 Mar 2007 13:52:50 -0700 (PDT)
Message-ID: <cda58cb80703231352g687bff78q42ec8f84cb80d103@mail.gmail.com>
Date:	Fri, 23 Mar 2007 21:52:50 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: flush_anon_page for MIPS
Cc:	"Miklos Szeredi" <miklos@szeredi.hu>, linux-mips@linux-mips.org,
	Ravi.Pratap@hillcrestlabs.com
In-Reply-To: <20070323153621.GB19477@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <E1HUVlw-00034H-00@dorka.pomaz.szeredi.hu>
	 <20070323141939.GB17311@linux-mips.org>
	 <cda58cb80703230801v5ce4baacr9b40119ff3342ac8@mail.gmail.com>
	 <20070323153621.GB19477@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 3/23/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> course that will still leave the unused body of __flush_anon_page around,
> how sad ;)
>

At this point,  ISTR there are some tools which can be used to remove dead code.
-- 
               Franck
