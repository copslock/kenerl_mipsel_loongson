Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Mar 2005 10:41:52 +0100 (BST)
Received: from web15805.mail.cnb.yahoo.com ([IPv6:::ffff:202.165.102.85]:5462
	"HELO web15805.mail.cnb.yahoo.com") by linux-mips.org with SMTP
	id <S8226006AbVCaJl3>; Thu, 31 Mar 2005 10:41:29 +0100
Message-ID: <20050331094116.66254.qmail@web15805.mail.cnb.yahoo.com>
Received: from [210.76.108.109] by web15805.mail.cnb.yahoo.com via HTTP; Thu, 31 Mar 2005 17:41:15 CST
Date:	Thu, 31 Mar 2005 17:41:15 +0800 (CST)
From:	dfsd df <tomcs163@yahoo.com.cn>
Subject: Re: Some questions about kernel tailoring
To:	linux-mips@linux-mips.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-611930826-1112262075=:64927"
Content-Transfer-Encoding: 8bit
Return-Path: <tomcs163@yahoo.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tomcs163@yahoo.com.cn
Precedence: bulk
X-list: linux-mips

--0-611930826-1112262075=:64927
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

Thanks again!
 
Because of the limitation of memory, I don't want to use YAMON. 
Using gzip -9, I can get a kernel more small than the kernel made by "make zImage". 
So I want to write a very simple bootloader and make a self-decompressed kernel.
 
But why everyone use "make zImage" instead of my method? That's what puzzles me? 

Stuart Longland <stuartl@longlandclan.hopto.org> wrote:
dfsd df wrote:
> Thanks for your reply!
> 
>>That's correct... 'vmlinux' is your kernel. mips
>>doesn't use zImages.
> 
> But , the vmlinux is too big, Waht should I do? Is the
> vmlinux already compressed?

Normally you manually gzip it -- but it will largely depend on what the
bootloader for your device expects. Incidentally, are you trying to
boot the kernel directly, or via something like U-boot or YAMON?
AFAIK these evaluation boards are not designed to directly boot a kernel.

>>(PS... Please refrain from HTML email on this list)
> Sorry, I'm a newbie, I really don't know what you
> mean. :-)

Rich text emails -- in layman's terms. Couple of reasons for this:
* They do make the email slightly larger
* Not everyone can see HTML
* SPAM and Viruses commonly exploit HTML

Never mind though, as it seems your mail client has figured to use
plaintext already. ;-)

-- 
+-------------------------------------------------------------+
| Stuart Longland -oOo- http://stuartl.longlandclan.hopto.org |
| Atomic Linux Project -oOo- http://atomicl.berlios.de |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
| I haven't lost my mind - it's backed up on a tape somewhere |
+-------------------------------------------------------------+



---------------------------------
Do You Yahoo!?
150万曲MP3疯狂搜，带您闯入音乐殿堂
美女明星应有尽有，搜遍美图、艳图和酷图
1G就是1000兆，雅虎电邮自助扩容！
--0-611930826-1112262075=:64927
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

<DIV>Thanks again!</DIV>
<DIV>&nbsp;</DIV>
<DIV>Because of the limitation of memory, I don't want to use YAMON. </DIV>
<DIV>Using gzip -9, I can get a kernel more small than the kernel made by "make zImage". </DIV>
<DIV>So I want to write a very simple&nbsp;bootloader and&nbsp;make a self-decompressed kernel.</DIV>
<DIV>&nbsp;</DIV>
<DIV>But why&nbsp;everyone use "make zImage" instead of my method? That's what&nbsp;puzzles me?&nbsp;<BR><BR><B><I>Stuart Longland &lt;stuartl@longlandclan.hopto.org&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">dfsd df wrote:<BR>&gt; Thanks for your reply!<BR>&gt; <BR>&gt;&gt;That's correct... 'vmlinux' is your kernel. mips<BR>&gt;&gt;doesn't use zImages.<BR>&gt; <BR>&gt; But , the vmlinux is too big, Waht should I do? Is the<BR>&gt; vmlinux already compressed?<BR><BR>Normally you manually gzip it -- but it will largely depend on what the<BR>bootloader for your device expects. Incidentally, are you trying to<BR>boot the kernel directly, or via something like U-boot or YAMON?<BR>AFAIK these evaluation boards are not designed to directly boot a kernel.<BR><BR>&gt;&gt;(PS... Please refrain from HTML email on this list)<BR>&gt; Sorry, I'm a newbie, I really don't know what you<BR>&gt; mean. :-)<BR><BR>Rich text emails -- in layman's terms. Couple of reasons for this:<BR>* They do make the email slightly larger<BR>* Not everyone can see HTML<BR>* SPAM and Viruses commonly exploit
 HTML<BR><BR>Never mind though, as it seems your mail client has figured to use<BR>plaintext already. ;-)<BR><BR>-- <BR>+-------------------------------------------------------------+<BR>| Stuart Longland -oOo- http://stuartl.longlandclan.hopto.org |<BR>| Atomic Linux Project -oOo- http://atomicl.berlios.de |<BR>| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |<BR>| I haven't lost my mind - it's backed up on a tape somewhere |<BR>+-------------------------------------------------------------+<BR></BLOCKQUOTE><p><br><hr size=1><b>Do You Yahoo!?</b><br>
<a href="http://music.yisou.com" target=blank>150万曲MP3疯狂搜，带您闯入音乐殿堂</a><br><a href="http://image.yisou.com" target=blank>美女明星应有尽有，搜遍美图、艳图和酷图</a><br>
<a href="http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/" target=blank>1G就是1000兆，雅虎电邮自助扩容！</a>
--0-611930826-1112262075=:64927--
