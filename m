Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jun 2006 13:37:51 +0100 (BST)
Received: from web38412.mail.mud.yahoo.com ([209.191.125.43]:28822 "HELO
	web38412.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133927AbWFFMhm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Jun 2006 13:37:42 +0100
Received: (qmail 19117 invoked by uid 60001); 6 Jun 2006 12:37:35 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=l0JdGT+xDR6dzpku+rbSaPcQ+NcGG31xW4nyE0nfyDPLPjhuu33S4zfE+ZjYib6XGNoeAMd/W1oGDjzBvqRAdRFNcOb6A6pa8Nh10qYEQK8RCcAyjkzRNlTMu2V/11avEFRLIha3LUMCNdPlDipVGhonUXybASVQjrRWWYh3GqA=  ;
Message-ID: <20060606123735.19115.qmail@web38412.mail.mud.yahoo.com>
Received: from [203.92.57.132] by web38412.mail.mud.yahoo.com via HTTP; Tue, 06 Jun 2006 05:37:35 PDT
Date:	Tue, 6 Jun 2006 05:37:35 -0700 (PDT)
From:	ashley jones <ashley_jones_2000@yahoo.com>
Subject: Re: Socket buffer allocation outside DMA-able memory
To:	art <art@sigrand.ru>, linux-mips@linux-mips.org
In-Reply-To: <6851.060602@sigrand.ru>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-263030290-1149597455=:14044"
Content-Transfer-Encoding: 8bit
Return-Path: <ashley_jones_2000@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashley_jones_2000@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-263030290-1149597455=:14044
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

hi,
         I guess your 25 bit dma address field will be word alligned, so ur dma engine will be able to index up to 64 MB( 25+2 = 27 bits).
   
          If that is not the case then you can use one of the foll. work around,
   
    * dont give whole 64 MB to linux, give only Lower 32 MB.
    * Give only upper 32 MB to linux, and give memory to ur dma engine from lower 32 MB, and once you recv any data you copy to skb and submit to linux. ( ofcourse your performance will get hit in this case.)
   
   
  Regards,
  A'Jones.
  

art <art@sigrand.ru> wrote:
  Hello all!
I work with ADM5120 chip. it has embedded switch.
Switch descriptor has 25-bit dma addres field - so addressible only
32Mb!
My system has 64Mb memory. But I have to set 32Mb to make it work!
I thought that setting DMA mask can help. So in
/arch/mips/adm5120/setup.c i make:

static struct platform_device adm5120hcd_device = {
.name = "adm5120-hcd",
.id = -1,
.dev = {
.dma_mask = &hcd_dmamask,
.coherent_dma_mask = 0x01ffffff,
},
.num_resources = ARRAY_SIZE(adm5120_hcd_resources),
.resource = adm5120_hcd_resources,
};
But It is wrong, because dev_alloc_skb dont know to which device it
allocates buffer!

How to tell kernel allocate skbuffers in less then 32Mb addrspace whet
system has 64Mb?

-- 
Best regards,
art mailto:art@sigrand.ru





__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-263030290-1149597455=:14044
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>hi,</div>  <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I guess your 25 bit dma address field will be word alligned, so ur dma engine will be able to index up to 64 MB( 25+2 = 27 bits).</div>  <div>&nbsp;</div>  <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; If that is not the case then you can use one of the foll. work around,</div>  <div>&nbsp;</div>  <div>&nbsp; * dont give whole 64 MB to linux, give only Lower 32 MB.</div>  <div>&nbsp; * Give only upper 32 MB to linux, and give memory to ur dma engine from lower 32 MB, and once you recv any data you copy to skb and submit to linux. ( ofcourse your performance will get hit in this case.)</div>  <div>&nbsp;</div>  <div>&nbsp;</div>  <div>Regards,</div>  <div>A'Jones.</div>  <div><BR><BR><B><I>art &lt;art@sigrand.ru&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hello all!<BR>I work with ADM5120 chip. it has embedded switch.<BR>Switch
 descriptor has 25-bit dma addres field - so addressible only<BR>32Mb!<BR>My system has 64Mb memory. But I have to set 32Mb to make it work!<BR>I thought that setting DMA mask can help. So in<BR>/arch/mips/adm5120/setup.c i make:<BR><BR>static struct platform_device adm5120hcd_device = {<BR>.name = "adm5120-hcd",<BR>.id = -1,<BR>.dev = {<BR>.dma_mask = &amp;hcd_dmamask,<BR>.coherent_dma_mask = 0x01ffffff,<BR>},<BR>.num_resources = ARRAY_SIZE(adm5120_hcd_resources),<BR>.resource = adm5120_hcd_resources,<BR>};<BR>But It is wrong, because dev_alloc_skb dont know to which device it<BR>allocates buffer!<BR><BR>How to tell kernel allocate skbuffers in less then 32Mb addrspace whet<BR>system has 64Mb?<BR><BR>-- <BR>Best regards,<BR>art mailto:art@sigrand.ru<BR><BR><BR><BR></BLOCKQUOTE><BR><p>__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-263030290-1149597455=:14044--
