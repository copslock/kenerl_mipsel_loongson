Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2005 21:45:48 +0100 (BST)
Received: from web40914.mail.yahoo.com ([IPv6:::ffff:66.218.78.211]:36992 "HELO
	web40914.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8224920AbVDGUpd>; Thu, 7 Apr 2005 21:45:33 +0100
Received: (qmail 52642 invoked by uid 60001); 7 Apr 2005 20:45:26 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=FJT83l2dNzRMTTGCbpFbsk6nqYgCnAQsImEqSibGrev4755/3J92e2+ec0pci0CewupFpBQ9qyyKaa49DPSPEj0M/gbKIIB2gb/EnkukmcDxf3QQ+qMMvCYPn9PwtB70giHXMHlDXt91NwKMoIWqGoI9COSSSXwNY6k/u5HYuFc=  ;
Message-ID: <20050407204526.52640.qmail@web40914.mail.yahoo.com>
Received: from [65.205.244.66] by web40914.mail.yahoo.com via HTTP; Thu, 07 Apr 2005 13:45:26 PDT
Date:	Thu, 7 Apr 2005 13:45:26 -0700 (PDT)
From:	Brian Kuschak <bkuschak@yahoo.com>
Subject: Re: gdb backtrace with core files
To:	Greg Weeks <greg.weeks@timesys.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <bkuschak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bkuschak@yahoo.com
Precedence: bulk
X-list: linux-mips

Which kernel version are you using?  Are you getting a
complete backtrace with the x86-hosted gdb?

Thanks,
Brian

--- Greg Weeks <greg.weeks@timesys.com> wrote:
> Brian Kuschak wrote:
> 
> >Greg,
> >
> >Is your GDB hosted on MIPS or another machine?  Are
> >those patches freely available?  If so, can you
> >  
> >
> OK, I checked.
> 
> Most of what's in our patches should be in gdb HEAD.
> We're currently at 
> 6.2.1 and don't want to take the time to move to
> head. If you're 
> interested and no one objects I can post them to the
> mips list. There 
> are 37 patches totaling 285K. Not all are mips
> related and gdb isn't 
> totally working for me yet.
> 
> Greg Weeks
> 


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Small Business - Try our new resources site!
http://smallbusiness.yahoo.com/resources/ 
