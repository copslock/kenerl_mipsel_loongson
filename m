Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Sep 2006 21:06:32 +0100 (BST)
Received: from wx-out-0506.google.com ([66.249.82.235]:36267 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20039018AbWI0UGa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 27 Sep 2006 21:06:30 +0100
Received: by wx-out-0506.google.com with SMTP id h30so333170wxd
        for <linux-mips@linux-mips.org>; Wed, 27 Sep 2006 13:06:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=AByw2dLYvcnlVI/qxrSgCy9pKirqjoHibeKcgJHJPYHoa1APs2FLSY8GMV9xsI5pr9bqGkf29rQx79Ah2VLyWhnnf27CTYVqx3cpLyOGYGkJliDbCUwr4XCjRGZvfbY6olMh97NsEZDvePkYmrA9NHVS6ISs+tyAXtZBFisAGgk=
Received: by 10.70.65.8 with SMTP id n8mr1327951wxa;
        Wed, 27 Sep 2006 13:06:28 -0700 (PDT)
Received: from ?10.0.1.104? ( [71.243.124.123])
        by mx.gmail.com with ESMTP id h9sm1304341wxd.2006.09.27.13.06.27;
        Wed, 27 Sep 2006 13:06:28 -0700 (PDT)
Message-ID: <451AD9C1.6080608@gmail.com>
Date:	Wed, 27 Sep 2006 16:06:25 -0400
From:	Peter Watkins <treestem@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050831)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Samium Gromoff <deepfire@elvees.com>
CC:	linux-mips@linux-mips.org
Subject: Re: 16KB PAGE_SIZE on r4k
References: <200609221906.30516.deepfire@elvees.com>
In-Reply-To: <200609221906.30516.deepfire@elvees.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <treestem@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: treestem@gmail.com
Precedence: bulk
X-list: linux-mips

Samium Gromoff wrote:
> How reliable is 16KB PAGE_SIZE on r4k-likes in kernels around 2.6.17?
> 
> Is it known to work?
> 
> regards, Samium Gromoff
> 
> 

You might want to look at:

http://www.linux-mips.org/archives/linux-mips/2006-08/msg00294.html
http://www.linux-mips.org/archives/linux-mips/2006-08/msg00244.html
