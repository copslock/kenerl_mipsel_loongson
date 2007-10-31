Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2007 10:22:58 +0000 (GMT)
Received: from web7911.mail.in.yahoo.com ([202.86.4.87]:55379 "HELO
	web7911.mail.in.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20025490AbXJaKWs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 31 Oct 2007 10:22:48 +0000
Received: (qmail 50104 invoked by uid 60001); 31 Oct 2007 10:21:40 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=X-YMail-OSG:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=OMr1j68/GNKk6XX8bUPO6WUjILO/aDDB1MFOfIkyi7yyrOI6bux5FghxCdvMSBeaEN4mBIHfdHeWwptkgP+ESIKIHkwyjVQ7XICqYfp+u+mqxx+zHIQWIDawSJ4wJxbqyci6zb3VTujIHD6pKLVUw5Rq2CGEEsQfkLfjDRC2Khc=;
X-YMail-OSG: pEPN2y8VM1nePujhlcxKoH25vleqajzVOlzH30nIv27uLQBCpwH6Or6xG1jXe9c2ig--
Received: from [199.239.167.162] by web7911.mail.in.yahoo.com via HTTP; Wed, 31 Oct 2007 10:21:40 GMT
Date:	Wed, 31 Oct 2007 10:21:40 +0000 (GMT)
From:	sathesh babu <sathesh_edara2003@yahoo.co.in>
Subject: Re: Unknown Synbol:__gp_disp
To:	kaka <share.kt@gmail.com>, linux-mips@linux-mips.org,
	uclinux-dev@uclinux.org, linux-fbdev-users@lists.sourceforge.net
In-Reply-To: <eea8a9c90710300215l2fdd9bf6u2238f1f9d8f1d66e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-847549657-1193826100=:49894"
Content-Transfer-Encoding: 8bit
Message-ID: <168352.49894.qm@web7911.mail.in.yahoo.com>
Return-Path: <sathesh_edara2003@yahoo.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sathesh_edara2003@yahoo.co.in
Precedence: bulk
X-list: linux-mips

--0-847549657-1193826100=:49894
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,
    Please use "-mno-pic -mno-abicalls -G 0" cflags along with kernel  cflags  to build the your  module.
   
  Regards,
  Sathesh
  

kaka <share.kt@gmail.com> wrote:
    Hi All,
   
  While installing the driver by insmod cmd. i am getting the above error, Unknown Synbol:__gp_disp,
  I have added ``-fno-pic -mno-abicalls'' option in the make file as 
   
    $(BCM_OBJ_DIR)/%.o: %.c
  @echo '$(CC) -c $(notdir $<)'
  @$(CC) -fno-pic -mno-abicalls -MMD -c $(CFLAGS) $< -o $@
   
  I tried by adding those symbols in the CFLAGS
  CFLAGS += -fno-pic -mno-abicalls.
  But it didn't help my cause.
  Could anybody plz look in to the error and reply?
  Thanks in advance


-- 
Thanks & Regards,
kaka 




       
---------------------------------
 Bring your gang together - do your thing.  Start your group.
--0-847549657-1193826100=:49894
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi,</div>  <div>&nbsp; Please use "<FONT size=2>-mno-pic -mno-abicalls -G 0" cflags along with </FONT>kernel &nbsp;cflags&nbsp; to build the your &nbsp;module.</div>  <div>&nbsp;</div>  <div>Regards,</div>  <div>Sathesh<FONT size=2></div>  <div></FONT><BR><BR><B><I>kaka &lt;share.kt@gmail.com&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">  <DIV>Hi All,</DIV>  <DIV>&nbsp;</DIV>  <DIV>While installing the driver by insmod cmd. i am getting the above error, Unknown Synbol:__gp_disp,</DIV>  <DIV>I have added ``-fno-pic -mno-abicalls'' option in the make file as </DIV>  <DIV>&nbsp;</DIV>  <DIV><FONT size=2>  <div>$(BCM_OBJ_DIR)/%.o: %.c</div>  <div>@echo '$(CC) -c $(notdir $&lt;)'</div>  <div>@$(CC) -fno-pic -mno-abicalls -MMD -c $(CFLAGS) $&lt; -o $@</div>  <div>&nbsp;</div>  <div>I tried by adding those symbols in the CFLAGS</div><FONT size=2>  <div>CFLAGS +=&nbsp;-fno-pic
 -mno-abicalls.</div>  <div>But it didn't help my cause.</div>  <div>Could anybody plz look in to the error and reply?</div>  <div>Thanks in advance</div></FONT></FONT><BR clear=all><BR>-- <BR>Thanks &amp; Regards,<BR>kaka </DIV><BR clear=all><BR></BLOCKQUOTE><BR><p>&#32;


      <!--2--><hr size=1></hr> Bring your gang together - do your thing. <a href="http://in.rd.yahoo.com/tagline_groups_2/*http://in.promos.yahoo.com/groups"> Start your group.</a>
--0-847549657-1193826100=:49894--
