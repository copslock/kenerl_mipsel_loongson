Received:  by oss.sgi.com id <S553712AbRAORLD>;
	Mon, 15 Jan 2001 09:11:03 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:56841 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553695AbRAORLB>;
	Mon, 15 Jan 2001 09:11:01 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id DDDC7806; Mon, 15 Jan 2001 18:10:53 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 5D820F597; Mon, 15 Jan 2001 18:11:33 +0100 (CET)
Date:   Mon, 15 Jan 2001 18:11:33 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: crash in __alloc_bootmem_core on SGI current cvs
Message-ID: <20010115181133.A2439@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,
the current cvs kernel crashes in __alloc_bootmem_core here:

[...]
        printk("%s, %d memset %p 0 %d\n", __FUNCTION__, __LINE__, ret, size);
        memset(ret, 0, size);
        printk("%s, %d\n", __FUNCTION__, __LINE__);
        return ret;
[...]

Output coming:

__alloc_bootmem_core, 230
__alloc_bootmem_core, 234 memset 81000000 0 36864

I guess this is really bogus as the ARCS MEMORY debug gives:

[0,a8748da0]: base<00000000> pages<00000001> type<Exception Block>              
[1,a8748dbc]: base<00000001> pages<00000001> type<ARCS Romvec Page>             
[2,a8748d84]: base<00008002> pages<00000173> type<Standlong Program Pages>      
[3,a87491cc]: base<00008175> pages<000005cb> type<Generic Free RAM>             
[4,a874919c]: base<00008740> pages<000000c0> type<ARCS Temp Storage Area>       
[5,a8749180]: base<00008800> pages<00007800> type<Generic Free RAM>            

Might this be the sgi/arc bootmem/memory.c doesnt alloc everything
or frees to much ?

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
