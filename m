Received:  by oss.sgi.com id <S553750AbQKBA0y>;
	Wed, 1 Nov 2000 16:26:54 -0800
Received: from rotor.chem.unr.edu ([134.197.32.176]:35594 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S553740AbQKBA0m>;
	Wed, 1 Nov 2000 16:26:42 -0800
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id QAA17850;
	Wed, 1 Nov 2000 16:25:56 -0800
Date:   Wed, 1 Nov 2000 16:25:56 -0800
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     Ian Chilton <mailinglist@ichilton.co.uk>
Cc:     linux-mips@oss.sgi.com
Subject: Re: GCC Compile Failed
Message-ID: <20001101162556.C17186@chem.unr.edu>
References: <20001101224303.A28369@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001101224303.A28369@woody.ichilton.co.uk>; from mailinglist@ichilton.co.uk on Wed, Nov 01, 2000 at 10:43:04PM +0000
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Nov 01, 2000 at 10:43:04PM +0000, Ian Chilton wrote:

> /mnt/hd2/lfstmp/glibc-001027/glibc-build/libc.so.6: undefined reference to `__pthread_initialize_minimal'
> collect2: ld returned 1 exit status
> make[2]: *** [/mnt/hd2/lfstmp/glibc-001027/glibc-build/iconv/iconv_prog] Error 1

Asked and answered. That archaic compiler cannot be used to build
glibc 2.2 because it doesn't deal with weak symbol references
properly.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
