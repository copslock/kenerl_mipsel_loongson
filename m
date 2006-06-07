Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jun 2006 06:18:11 +0100 (BST)
Received: from web38409.mail.mud.yahoo.com ([209.191.125.40]:39833 "HELO
	web38409.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8126552AbWFGFSD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Jun 2006 06:18:03 +0100
Received: (qmail 66062 invoked by uid 60001); 7 Jun 2006 05:17:56 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=vtJTcNW5zdNEPrPeUhpVMMIIgmDVUXGx6G+2/KHD8q8pox9ku6MafRAEqHCN7Neq62FXjEp7S3bSGsJ6gjAXL8f0tXuHgjmpgpJB+90PzFBhOf+gPvGYVvgpHzbaTQFpvR0Oh/4H4qR1nccnN+/14QfXvbx74Mapx6fkmIrLGd8=  ;
Message-ID: <20060607051756.66058.qmail@web38409.mail.mud.yahoo.com>
Received: from [203.92.57.132] by web38409.mail.mud.yahoo.com via HTTP; Tue, 06 Jun 2006 22:17:56 PDT
Date:	Tue, 6 Jun 2006 22:17:56 -0700 (PDT)
From:	ashley jones <ashley_jones_2000@yahoo.com>
Subject: Re: Re[2]: Socket buffer allocation outside DMA-able memory
To:	art <art@sigrand.ru>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <15450.060607@sigrand.ru>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2105202544-1149657476=:65043"
Content-Transfer-Encoding: 8bit
Return-Path: <ashley_jones_2000@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashley_jones_2000@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-2105202544-1149657476=:65043
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


art <art@sigrand.ru> wrote:    Hello ashley,

Tuesday, June 06, 2006, 7:37:35 PM, you wrote:


aj> I guess your 25 bit dma address field will be word alligned, so ur dma engine will be able to index up to 64 MB( 25+2 = 27 bits).
Address not aligned - if I don't do anything driver work incorrect!
   
  *** what do you mean by Address not aligned ??
   
  *** What address you r passing to dma ? u should pass (skb->data >> 2) (if word alligned address is required for dma engine.)

aj> * dont give whole 64 MB to linux, give only Lower 32 MB.
You mean with command line kernel option? If so - I already did so to
get all work!

  *** when you do add_memory_region(), give only first 32 MB to linux, so all the skbs will be in lower 32 MB range.
   
  aj> * Give only upper 32 MB to linux, and give memory to ur dma engine from lower 32 MB, and once you recv any data you copy to skb and submit to linux. ( ofcourse your performance will get hit
aj> in this case.)
How can I do this? I have variant that if addres is upper than 32Mb then copy skbuffer to
previously allocated memory that lower than 32Mb, but perfomance is wery Important. Maybe
you mean this??




A'Jones.

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-2105202544-1149657476=:65043
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<BR><B><I>art &lt;art@sigrand.ru&gt;</I></B> wrote:  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">  <div>Hello ashley,<BR><BR>Tuesday, June 06, 2006, 7:37:35 PM, you wrote:<BR><BR><BR>aj&gt; I guess your 25 bit dma address field will be word alligned, so ur dma engine will be able to index up to 64 MB( 25+2 = 27 bits).<BR>Address not aligned - if I don't do anything driver work incorrect!</div>  <div>&nbsp;</div>  <div>*** what do you mean by Address not aligned ??</div>  <div>&nbsp;</div>  <div>*** What address you r passing to dma ? u should pass (skb-&gt;data &gt;&gt; 2)&nbsp;(if word alligned address is required for dma engine.)<BR><BR>aj&gt; * dont give whole 64 MB to linux, give only Lower 32 MB.<BR>You mean with command line kernel option? If so - I already did so to<BR>get all work!<BR></div>  <div>*** when you do add_memory_region(), give only first 32 MB to linux, so all the skbs will be in lower 32 MB
 range.</div>  <div>&nbsp;</div>  <div>aj&gt; * Give only upper 32 MB to linux, and give memory to ur dma engine from lower 32 MB, and once you recv any data you copy to skb and submit to linux. ( ofcourse your performance will get hit<BR>aj&gt; in this case.)<BR>How can I do this? I have variant that if addres is upper than 32Mb then copy skbuffer to<BR>previously allocated memory that lower than 32Mb, but perfomance is wery Important. Maybe<BR>you mean this??<BR><BR><BR><BR></div></BLOCKQUOTE>A'Jones.<BR><p>__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-2105202544-1149657476=:65043--
